require 'bundler'

Bundler.require

module NexusLab

    $APPLICATION_NAME = 'NexusLab'

    class ApplicationController < Sinatra::Base
        
        configure do
            set :root, File.dirname(__FILE__)
            set :public_folder, 'public'
            set :views, 'views'
            set :application_name, 'NexusLab'
            set :database_file, 'config/database.yml'
            set :bind, '0.0.0.0'

            register Sinatra::ActiveRecordExtension
            register Sinatra::Flash
        end

        before do
            headers "X-Flag" => "TAC{10712ba4809df3ba147b54db4373ad2864ecf5480b0bad46ebd505c35a946435}"
        end

        configure :development do
            register Sinatra::Reloader
        end

        not_found do
            status 200
            erb :not_found
        end

        error 500 do
            status 200
            erb :server_error
        end

        error 403 do
            status 200
            erb :forbidden
        end

        def is_logged_in?
            !session[:id].nil?
        end

        def is_admin?
            session[:admin]
        end
    end

end
