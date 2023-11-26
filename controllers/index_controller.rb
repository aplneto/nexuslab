module NexusLab
    class IndexController < NexusLab::ApplicationController
        
        get '/' do
            erb :index
        end

        get '/faq' do
            @questions = Question.all
            erb :faq
        end

        get '/avisos/:id' do
            @notification = Notification.find_by(id: params[:id])
            if @notification.nil?
                halt 404
            end
            erb :notification
        end

        get '/avisos/' do
            @notifications = Notification.all
            erb :notifications
        end
    end
end