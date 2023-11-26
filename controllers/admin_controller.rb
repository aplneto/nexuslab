module NexusLab
    class AdminController < NexusLab::ApplicationController
        before do
            unless is_admin?
                halt 403
            end
        end

        get "/" do
            erb :admin do
                erb :"admin/panel"
            end
        end

        get "/avisos" do
            if params.key?("id")
                @aviso = Notification.find_by(id: params[:id])
            end
            erb :admin do
                erb :"admin/avisos"
            end
        end

        get "/projects" do
            @projects = Project.all.order(updated_ad: :desc)

            erb :admin do
                erb :project
            end
        end

        get "/users" do
            @users = User.all
            erb :admin do
                erb :"admin/users"
            end
        end

        get "/debug" do
            erb :admin do
                erb :"admin/debug"
            end
        end

        post "/avisos" do
            params[:user_id] = session[:id]
            unless params.key?(:id)
                Notification.create(params)
            else
                notification = Notification.find_by(id: params[:id])
                notification.update(params)
            end
            
            redirect to('/avisos')
        end

        get '/avisos/delete/:id' do
            Notification.find_by(id: params[:id]).destroy
            redirect '/'
        end
    end
end