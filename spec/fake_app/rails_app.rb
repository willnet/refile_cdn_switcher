require 'active_record'

FakeApp = Class.new(Rails::Application)
FakeApp.config.session_store :cookie_store, key: '_myapp_session'
FakeApp.config.eager_load = false
FakeApp.config.root = File.dirname(__FILE__)
FakeApp.initialize!

FakeApp.routes.draw do
  root 'welcome#index'
end

class WelcomeController < ActionController::Base
  def index
  end
end


ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string "file_id", null: false
    t.string "file_filename", null: false
    t.integer "file_size", null: false
    t.string "file_content_type", null: false
  end

  create_table :posts, force: true do |t|
    t.string "file_id", null: false
    t.string "file_filename", null: false
    t.integer "file_size", null: false
    t.string "file_content_type", null: false
  end
end

class Post < ActiveRecord::Base
  attachment :file
end

class User < ActiveRecord::Base
  attachment :file, cdn: true
end

CDN_HOST = 'http://cdn.example.com'

Refile.secret_key = '9ea57f47030555694c3abcdc7b3bf9769d600f061a87052fb09259ee22bb1355ecb3ced4be4894f151ccc35cec3ff497cff42e536648361d5ccfa0d26d31b066'
Rails.application.routes.default_url_options = { host: 'localhost', port: 8080 }
