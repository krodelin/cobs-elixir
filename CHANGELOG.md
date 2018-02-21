# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2018-02-21
### Added
- Added exception throwing versions `Cobs.encode!/1` and `Cobs.decode!/1`

### Changed
- Changed `Cobs.encode/1` and `Cobs.decode/1` to return tuples (`{:ok, result}` and `{:error, message}`).
  Please note that this is a *breaking API change*!


## [0.1.3] - 2018-02-20
### Fixed
- Fixed ex_doc main page filename (again)

## [0.1.2] - 2018-02-20
### Changed
- Changed installation instructions in README

### Fixed
- Fixed ex_doc main page filename
- Fixed hex.pm description (removed markdown)

## [0.1.1] - 2018-02-20
### Added
- Added CHANGELOG
- Update README

## [0.1.0] - 2018-02-20
### Added
- Initial commit

[0.2.0]: https://github.com/krodelin/cobs-elixir/releases/tag/0.2.0
[0.1.3]: https://github.com/krodelin/cobs-elixir/releases/tag/0.1.3
[0.1.2]: https://github.com/krodelin/cobs-elixir/releases/tag/0.1.2
[0.1.1]: https://github.com/krodelin/cobs-elixir/releases/tag/0.1.1
[0.1.0]: https://github.com/krodelin/cobs-elixir/releases/tag/0.1.0