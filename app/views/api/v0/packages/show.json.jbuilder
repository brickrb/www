json.extract! @package, :id, :name, :latest_version, :license

json.contributors @package.ownerships, :fullname, :email

json.versions @package.versions, :number, :shasum, :tarball
