# Hello World

The Hello World examples included here, if you want, are self contained by using
Docker and Docker Compose and intended to be used with example projects shipped
with the main distribution.

We've included the Hello World example DDL in the `helloworld.sql`file.

## Instructions

Follow the instructions in the VoltDB kit's `doc/tutorials/helloworld` folder to
start the database and load the schema. OR you could use Docker with Docker
Compose to have everything self contained.

If you end up wanting to use Docker use the `run.sh` script to setup VoltDB and
the DDL.

- `helloworld.rb`: sync functionality just as the Java example.
- `helloworld_async.rb`: async functionality just as the Java example.
- `helloworld_utilities.rb`: sync functionality using Full 360 utilities.
- `helloworld_utilities_async.rb`: sync functionality using Full 360 utilities.

Run the following command to start the sync helloworld example:

    ruby helloworld.rb

In the same way just substitute the file name to run any of the other examples.
