json.extract! @package, :id, :name, :description, :latest_version

json.contributors @package.ownerships, :fullname, :email

json.versions @package.versions, :number, :license, :shasum, :tarball
