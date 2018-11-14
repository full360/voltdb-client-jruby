# Changelog

## 0.8.0

- Update the wrapper client to VoltDB 8.3
  [#9](https://github.com/full360/voltdb-client-jruby/pull/9)
  - Revert remove `pry` as a development dependency
  - Update the voltdbclient jar to version 8.3
  - Remove deprecated `update_application_catalog`
  - Add more delegate methods including some deprecated ones
  - Add new `BulkLoaderSuccessCallback`
  - Update `get_new_bulk_loader` with new signature. This is a breaking change as
    the method now receives two Procs instead of one block
  - Remove intermediate object creation where possible
  - Fix examples to make them work with version 8.3
  - Add more code YARD comments
- Update Travis CI to work with JRuby 9.2 and 9.1 and also deploy on tags
  [#13](https://github.com/full360/voltdb-client-jruby/pull/13)

## 0.5.0

- Remove `pry` as a development dependency
- Add the examples dir with the Hello World example
  [#5](https://github.com/full360/voltdb-client-jruby/pull/5)
- Set Platform to Java for the Gem and Vendor the `voltdbclient-6.8.jar` using
  `jar-dependencies` [#6](https://github.com/full360/voltdb-client-jruby/pull/6)

## 0.4.1

- Remove `voltdbclient-6.8.jar` as a dependency from the Gem
- Update development dependencies
