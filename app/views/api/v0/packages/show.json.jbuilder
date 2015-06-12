json.extract! @package, :id, :name, :description, :latest_version_number

json.contributors @package.ownerships, :fullname, :email

json.versions @package.versions, :number, :license, :shasum, :tarball
