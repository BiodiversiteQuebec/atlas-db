
---revoke all on every role in schemas--- 
REVOKE ALL ON schema public FROM public;
REVOKE ALL ON schema public_api FROM public;
REVOKE ALL ON schema api FROM public;
REVOKE ALL ON schema observations_partitions FROM public;

REVOKE ALL ON schema public FROM read_only_all;
REVOKE ALL ON schema public_api FROM read_only_all;
REVOKE ALL ON schema api FROM read_only_all;
REVOKE ALL ON schema observations_partitions FROM read_only_all;


REVOKE ALL ON schema public FROM read_only_public;
REVOKE ALL ON schema public_api FROM read_only_public;
REVOKE ALL ON schema api FROM read_only_public;
REVOKE ALL ON schema observations_partitions FROM read_only_public;

REVOKE ALL ON schema public FROM read_write_all;
REVOKE ALL ON schema public_api FROM read_write_all;
REVOKE ALL ON schema api FROM read_write_all;
REVOKE ALL ON schema observations_partitions FROM read_write_all;


---revoke all on every role when a ressource is created------
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public REVOKE ALL ON TABLES FROM PUBLIC; -- this one is important since new roles inherit privilegies from public so it is safety to remove all privilegies from PUBLIC before anything--

ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public REVOKE ALL ON TABLES FROM read_only_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public REVOKE ALL ON TABLES FROM read_only_public;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public REVOKE ALL ON TABLES FROM read_write_all;


---read_only_all access ---- 
--- Before role can access to something inside of schema the usage privilege has to be granted 
GRANT USAGE ON SCHEMA public TO read_only_all;
GRANT USAGE ON SCHEMA public_api TO read_only_all;
GRANT USAGE ON SCHEMA api TO read_only_all;

ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public GRANT SELECT ON TABLES TO read_only_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public GRANT USAGE ON SEQUENCES TO read_only_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public GRANT EXECUTE ON FUNCTIONS TO read_only_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public_api GRANT SELECT ON TABLES TO read_only_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public_api GRANT USAGE ON SEQUENCES TO read_only_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public_api GRANT EXECUTE ON FUNCTIONS TO read_only_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA api GRANT SELECT ON TABLES TO read_only_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA api GRANT USAGE ON SEQUENCES TO read_only_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA api GRANT EXECUTE ON FUNCTIONS TO read_only_all;


---read_only_public access ---- 
--- Before role can access to something inside of schema the usage privilege has to be granted
GRANT USAGE ON SCHEMA public TO read_only_public;
GRANT USAGE ON SCHEMA public_api TO read_only_public;
GRANT USAGE ON SCHEMA api TO read_only_public;

REVOKE ALL ON ALL TABLES IN SCHEMA public FROM read_only_public;

ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public_api GRANT SELECT ON TABLES TO read_only_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public_api GRANT USAGE ON SEQUENCES TO read_only_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public_api GRANT EXECUTE ON FUNCTIONS TO read_only_all;

ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public_api GRANT SELECT ON TABLES TO read_only_public;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public_api GRANT USAGE ON SEQUENCES TO read_only_public;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public_api GRANT EXECUTE ON FUNCTIONS TO read_only_public;


---grant full access to read_write role except delete (only postgres user can remove)-----
GRANT USAGE ON SCHEMA public TO read_write_all;
GRANT USAGE ON SCHEMA public_api TO read_write_all;
GRANT USAGE ON SCHEMA api TO read_write_all;
GRANT USAGE ON SCHEMA observations_partitions TO read_write_all;

ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public GRANT SELECT,INSERT, UPDATE, TRUNCATE, REFERENCES,TRIGGER ON TABLES TO read_write_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO read_write_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO read_write_all;

GRANT SELECT,INSERT, UPDATE, TRUNCATE, REFERENCES, TRIGGER ON ALL TABLES IN SCHEMA public TO read_write_all;
GRANT SELECT,INSERT, UPDATE, TRUNCATE, REFERENCES, TRIGGER ON ALL TABLES IN SCHEMA public_api TO read_write_all;
GRANT SELECT,INSERT, UPDATE, TRUNCATE, REFERENCES, TRIGGER ON ALL TABLES IN SCHEMA api TO read_write_all;
GRANT SELECT, INSERT, UPDATE, TRUNCATE, REFERENCES, TRIGGER ON ALL TABLES IN SCHEMA observations_partitions TO read_write_all;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO read_write_all;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public_api TO read_write_all;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA api TO read_write_all;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA observations_partitions TO read_write_all;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO read_write_all;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public_api TO read_write_all;
GRANT ALL ON ALL SEQUENCES IN SCHEMA api TO read_write_all;
GRANT ALL ON ALL SEQUENCES IN SCHEMA observations_partitions TO read_write_all;


--- only once ---
---GRANT read_write_all TO belv1601 GRANTED BY postgres;
---GRANT read_write_all TO vbeaure GRANTED BY postgres;
---GRANT read_write_all TO cabw2601 GRANTED BY postgres;