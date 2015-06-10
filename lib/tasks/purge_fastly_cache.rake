namespace :fastly do
  desc "Purge Fastly cache (takes about 5s)"
  task :purge do
    require Rails.root.join("config/initializers/fastly")
    FastlyRails.client.get_service(ENV["FASTLY_SERVICE_ID"]).purge_all
    puts "Cache purged"
  end
end
