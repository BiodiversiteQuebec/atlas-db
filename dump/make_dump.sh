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
    -n public \
    -n public_api \
    -n atlas_api \
    -n api \
    -T observations \
    -T obs_efforts \
    -T public.montreal_terrestrial_limits \
    -T public.regions \
    -T qc_limit \
    -T qc_region_limit \
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

# Dump regions of type hex in dump_regions_hex.sql
echo "SET session_replication_role = 'replica';" > dump_regions_hex.sql
echo "COPY public.regions FROM stdin;">>dump_regions_hex.sql
psql -c '
COPY (
    SELECT *
    FROM regions
    WHERE type = '\''hex'\'')
TO stdout'>>dump_regions_hex.sql
echo "\.">>dump_regions_hex.sql

# Dump regions of type cadre_eco in dump_regions_cadre_eco.sql
echo "SET session_replication_role = 'replica';" > dump_regions_cadre_eco.sql
echo "COPY public.regions FROM stdin;">>dump_regions_cadre_eco.sql
psql -c '
COPY (
    SELECT *
    FROM regions
    WHERE type = '\''cadre_eco'\'')
TO stdout'>>dump_regions_cadre_eco.sql
echo "\.">>dump_regions_cadre_eco.sql

# Dump regions of type hex in dump_regions_admin.sql
echo "SET session_replication_role = 'replica';" > dump_regions_admin.sql
echo "COPY public.regions FROM stdin;">>dump_regions_admin.sql
psql -c '
COPY (
    SELECT *
    FROM regions
    WHERE type = '\''admin'\'')
TO stdout'>>dump_regions_admin.sql
echo "\.">>dump_regions_admin.sql