module NexusLab
    class ProjectController < NexusLab::ApplicationController
        before do
            unless is_logged_in?
                halt 403
            end
        end

        get '/' do
            user = User.find_by(id: session[:id])
            @projects = Project.where(id: user.invitations.map(&:project_id)).or(user.projects)
            
            erb :project
        end

        get '/new' do
            erb :"project/new"
        end

        get '/:id' do
            redirect to("/#{params[:id]}/")
        end

        get '/:id/*' do
            @project = Project.find_by(id: params[:id])
            project_path = "projects/#{@project.user.id}/#{@project.title}"
            @project_tree = directory_hash(project_path, @project.title)
            @current_file_path = File.join(project_path, params[:splat].join('') || '')

            erb :"project/project" do
                if File.file?(@current_file_path)
                    send_file @current_file_path, :filename => params[:splat][-1], :type => 'Application/octet-stream'
                else
                    @directories = []
                    @files = []
                    Dir.foreach(@current_file_path) do |entry|
                        next if (entry == '..' || entry == '.')
                        file_path = File.join(@current_file_path, entry)
                        if File.directory? file_path
                            @directories << entry
                        else
                            @files << entry
                        end
                    end
                    erb :"project/directory_view"
                end
            end
        end

        post '/invite' do
            puts params.inspect
            project = Project.find_by(id: params[:id])
            user = User.find_by(username: params[:username])

            if user.nil?
                flash['user'] = ['Usuário não encontrado!']
            else
                invite = Invitation.create(
                    project_id: project.id,
                    user_id: user.id
                )

                unless invite.valid?
                    invite.errors.messages.each do |key, value|
                        flash[key] = value
                    end
                end
            end

            redirect back
        end

        # post '/' do
        #     # Change here to create invitation
        #     params[:user_id] = session[:id]
        #     project = Project.create(params)

        #     unless project.valid?
        #         project.errors.messages.each do |key, value|
        #             flash[key] = value
        #         end
                
        #         redirect to("/")
        #     else
        #         FileUtils.mkdir_p("projects/#{project.user.id}/#{project.title}")
        #         redirect to("/#{project.id}")
        #     end
        # end

        def directory_hash(path, name=nil)
            current_name = (name || path)
            children = []
            Dir.foreach(path) do |entry|
                next if (entry == '..' || entry == '.')
                full_path = File.join(path, entry)
                if File.directory? full_path
                    children << directory_hash(full_path, entry)
                else
                    children << entry
                end
            end
            data = { current_name => children }
            return data
        end
    end
end