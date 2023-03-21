
# установить через env
Sidekiq.configure_server do |config|
  # config.redis = { url: 'redis://0.0.0.0:6379/0' }
  config.redis = { url: 'redis://127.0.0.1:6379' }
end

Sidekiq.configure_client do |config|
  # config.redis = { url: 'redis://0.0.0.0:6379/0' }
  config.redis = { url: 'redis://127.0.0.1:6379' }
end
