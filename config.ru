require File.join(File.dirname(__FILE__), 'app.rb')

controller_dir = File.dirname(__FILE__), 'controllers/*_controller.rb'
Dir[File.join(controller_dir)].each do |file|
    require file
end

models_dir = File.dirname(__FILE__), 'models/*.rb'
Dir[File.join(models_dir)].each do |file|
    require file
end

use Rack::Session::Cookie, :expire_after => 60*60*3,
    :path => '/',
    :secret => "6e58a5d35ac0b2adeeff10d0501374fd"

map '/' do
    use NexusLab::IndexController
end

map '/admin' do
    use NexusLab::AdminController
end

map '/auth' do
    use NexusLab::AuthController
end

map '/user' do
    use NexusLab::UserController
end

map '/project' do
    use NexusLab::ProjectController
end

run NexusLab::ApplicationController