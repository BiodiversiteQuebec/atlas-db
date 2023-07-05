export PGDATABASE="atlas"

out_file="dump_atlas.sql"
obs_file="dump_test_observations.sql"

# Dump users and roles
echo "SET session_replication_role = 'replica';" > $out_file

pg_dumpall --roles-only >> $out_file

grep -v "CREATE ROLE postgres" $out_file > tmpfile && mv tmpfile $out_file
grep -v "ALTER ROLE postgres" $out_file > tmpfile && mv tmpfile $out_file

# Dump using -s to dump only schema and -a to dump only data
pg_dump -s --no-tablespaces \
    >> $out_file
pg_dump -a --if-exists\
    -T observations \
    -T obs_efforts \
    -T public.observations_backup_202111 \
    -T public_api.hex_250_na \
    -T public_api.hexquebec      \
    -T public_api.cadre_eco_quebec \
    -T public.montreal_terrestrial_limits \
    -N scratch_vbeaure   \
    -N observations_partitions \
    >> $out_file

# Dump selected observations in 'test_observations.txt' file and add line to copy in sql dump
echo "SET session_replication_role = 'replica';" > $obs_file 
psql -c 'create table public.test_observations (like public.observations including all);

insert into public.test_observations
select *
from public.observations
order by random()
limit 60000;'

echo "COPY public.observations FROM stdin;">>$obs_file
psql -c 'COPY test_observations TO stdout'>>$obs_file
echo "\.">>$obs_file

echo "COPY public.obs_efforts FROM stdin;">>$obs_file
psql -c '
COPY (
    SELECT *
    FROM obs_efforts
    WHERE id_obs IN (
        SELECT obs.id
        FROM test_observations obs))
TO stdout'>>$obs_file
echo "\.">>$obs_file

psql -c "drop table test_observations;"