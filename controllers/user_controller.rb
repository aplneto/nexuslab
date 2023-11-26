module NexusLab
    class UserController < NexusLab::ApplicationController
        get '/new' do
            @user = User.new
            @public_projects = []
            erb :"user/profile"
        end
        get '/:id' do
            @user = User.find_by(id: params[:id])
            if @user.nil?
                halt 404
            end
            @public_projects = @user.projects.where(is_public: true).or(@user.projects.where(user_id: session[:id]))
            erb :"user/profile"
        end

        delete '/:id' do
            halt 403
        end

        put '/:id' do
            user = User.find_by(id: params[:id])
            user.update(params)
            unless user.valid?
                user.errors.messages.each do |key, value|
                    flash[key] = value
                end
            end

            redirect to("/#{user.id}")
        end

        post '/' do
            user = User.create(params)
            unless user.valid?
                user.errors.messages.each do |key, value|
                    flash[key] = value
                end
            else
                redirect ('/auth/logout')
            end
        end

        get '/' do
            unless session.key?(:id)
                redirect '/auth/login'
            else
                redirect to("/#{session[:id]}")
            end
        end

        post '/upload_picture' do
            user = User.find_by(id: session[:id])
            if user.nil?
                halt 403
            end
            unless params[:picture][:filename] && params[:picture][:tempfile]
                halt 400
            end

            old_picture = "public/profiles/#{user.profile_picture}"

            if File.file?(old_picture)
                File.delete(old_picture)
            end

            picture_name = user.username + '_' + params[:picture][:filename]
            File.open("public/profiles/#{picture_name}", 'wb') do |f|
                f.write(params[:picture][:tempfile].read)
            end
            
            user.profile_picture = picture_name
            user.save

            redirect to('/')
        end
    end
end