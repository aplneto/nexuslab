require "sinatra/activerecord/rake"

namespace :db do
  task :load_config do
    require File.join(File.dirname(__FILE__), 'app.rb')

    models_dir = File.dirname(__FILE__), 'models/*.rb'
    Dir[File.join(models_dir)].each do |file|
        require file
    end
  end
end