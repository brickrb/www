json.array!(@packages) do |package|
  json.extract! package, :id, :name, :license
  json.url package_url(package, format: :json)
end
