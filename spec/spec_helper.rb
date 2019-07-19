$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'bundler/setup'
require 'action_controller/railtie'
require 'fileutils'

Bundler.require

require "refile_cdn_switcher"
require 'fake_app/rails_app'

Refile.backends['store'] = Refile::Backend::FileSystem.new('./tmp/store')
Refile.backends['cache'] = Refile::Backend::FileSystem.new('./tmp/cache')

RSpec.configure do |config|
  config.after(:suite) do
    FileUtils.rm_r Dir.glob('./tmp/store/*')
    FileUtils.rm_r Dir.glob('./tmp/cache/*')
  end
end
