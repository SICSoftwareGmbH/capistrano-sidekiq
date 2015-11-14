require 'capistrano/sidekiq/utility'

include Capistrano::Sidekiq::Utility

load File.expand_path('../sidekiq/tasks/sidekiq.cap', __FILE__)
