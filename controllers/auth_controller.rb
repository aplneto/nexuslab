module NexusLab
    class AuthController < NexusLab::ApplicationController
        
        get '/login' do
            if is_logged_in?
                redirect '/'
            else
                erb :"auth/login"
            end
        end

        post '/login' do
            email = params[:email]
            user = User.find_by(email: email)
            if (user)
                if (user.password) == params[:password]
                    @error = "Logged in!"
                    session[:id] = user.id
                    session[:admin] = user.is_admin
                    redirect '/'
                else
                    @error = "Senha incorreta!"
                end
            else
                @error = "E-mail não encontrado!"
            end

            erb :"auth/login"
        end

        get '/logout' do
            session.clear
            redirect '/'
        end

        get '/change_password' do
            @user = User.find_by(id: session[:id])
            if @user.nil?
                halt 404
            end
            erb :"auth/change_password"
        end

        post '/change_password' do
            @user = User.find_by(id: session[:id])
            if @user.password == params[:password]
                @user.password = params[:newPassword]
                @user.save
                session.clear
                redirect '/'
            else
                @error = "Senha incorreta!"
                erb :"auth/change_password"
            end

        end
    end
end
