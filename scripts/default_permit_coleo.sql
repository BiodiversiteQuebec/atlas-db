REVOKE ALL ON schema public FROM public;
REVOKE ALL ON schema api FROM public;
REVOKE ALL ON schema coleo_test FROM public;

REVOKE ALL ON schema public FROM read_only_all;
REVOKE ALL ON schema api FROM read_only_all;
REVOKE ALL ON schema coleo_test FROM read_only_all;

REVOKE ALL ON schema public FROM read_only_public;
REVOKE ALL ON schema api FROM read_only_public;
REVOKE ALL ON schema coleo_test FROM read_only_public;

REVOKE ALL ON schema public FROM read_write_all;
REVOKE ALL ON schema api FROM read_write_all;
REVOKE ALL ON schema coleo_test FROM read_write_all;

REVOKE ALL ON schema public FROM coleo_test_user;
REVOKE ALL ON schema api FROM coleo_test_user;
REVOKE ALL ON schema coleo_test FROM coleo_test_user;


---revoke all on every role when a ressource is created------
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public REVOKE ALL ON TABLES FROM public;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public REVOKE ALL ON TABLES FROM read_only_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public REVOKE ALL ON TABLES FROM read_only_public;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public REVOKE ALL ON TABLES FROM read_write_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public REVOKE ALL ON TABLES FROM coleo_test_user;

---public (role) access-----
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public GRANT SELECT ON TABLES TO public;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public GRANT USAGE ON SEQUENCES TO public;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public GRANT EXECUTE ON FUNCTIONS TO public;

---read_only_all access ---- 
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public GRANT SELECT ON TABLES TO read_only_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public GRANT USAGE ON SEQUENCES TO read_only_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public GRANT EXECUTE ON FUNCTIONS TO read_only_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA api GRANT SELECT ON TABLES TO read_only_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA api GRANT USAGE ON SEQUENCES TO read_only_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA api GRANT EXECUTE ON FUNCTIONS TO read_only_all;
GRANT USAGE ON SCHEMA api TO read_only_all;
GRANT USAGE ON SCHEMA public TO read_only_all;

---grant full access to read_write role except delete (only postgres user can remove)-----
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public GRANT SELECT,INSERT, UPDATE, TRUNCATE, REFERENCES,TRIGGER ON TABLES TO read_write_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO read_write_all;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO read_write_all;

GRANT USAGE ON SCHEMA public TO read_write_all;
GRANT USAGE ON SCHEMA api TO read_write_all;
GRANT SELECT,INSERT, UPDATE, TRUNCATE, REFERENCES,TRIGGER ON ALL TABLES IN SCHEMA public TO read_write_all;
GRANT SELECT,INSERT, UPDATE, TRUNCATE, REFERENCES,TRIGGER ON ALL TABLES IN SCHEMA api TO read_write_all;

GRANT ALL PRIVILEGES ON SCHEMA coleo_test TO read_write_all;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA coleo_test TO read_write_all;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA coleo_test TO read_write_all;

---admins (role)----
GRANT ALL PRIVILEGES ON SCHEMA coleo_test TO admins;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA coleo_test TO admins;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA coleo_test TO admins;

---coleo_test_user (role) access----
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA coleo_test GRANT ALL ON TABLES TO coleo_test_user;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA coleo_test GRANT ALL ON FUNCTIONS TO coleo_test_user;
ALTER DEFAULT PRIVILEGES FOR USER postgres IN SCHEMA coleo_test GRANT ALL ON SEQUENCES TO coleo_test_user;

GRANT ALL PRIVILEGES ON SCHEMA coleo_test TO coleo_test_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA coleo_test TO coleo_test_user;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA coleo_test TO coleo_test_user;

GRANT USAGE ON SCHEMA public TO coleo_test_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO coleo_test_user;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO coleo_test_user;

GRANT USAGE ON SCHEMA api TO coleo_test_user;
GRANT SELECT ON ALL TABLES IN SCHEMA api TO coleo_test_user;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA api TO coleo_test_user;




