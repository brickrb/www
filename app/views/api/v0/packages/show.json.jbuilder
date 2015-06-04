json.extract! @package, :id, :name, :latest_version, :license

json.versions @package.versions, :number, :shasum, :tarball
