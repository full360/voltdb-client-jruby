CREATE TABLE helloworld (
   hello VARCHAR(15),
   world VARCHAR(15),
   dialect VARCHAR(15) NOT NULL,
   PRIMARY KEY (DIALECT)
);
PARTITION TABLE HELLOWORLD ON COLUMN DIALECT;

CREATE PROCEDURE Insert PARTITION ON TABLE helloworld COLUMN dialect
   AS INSERT INTO helloworld (dialect, hello, world) VALUES (?, ?, ?);
CREATE PROCEDURE Select PARTITION ON TABLE helloworld COLUMN dialect
   AS SELECT hello, world FROM helloworld WHERE dialect = ?;
