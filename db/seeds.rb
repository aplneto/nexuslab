require 'faker'

questions = YAML.load_file("faq.yml")
questions.each do |question|
    Question.create(question)
end

users = YAML.load_file("users.yml")
users.each do |user|
    User.create(user)
end

projects = YAML.load_file("projects.yml")
projects.each do |project|
    Project.create(project)
    dir_name = "projects/#{project['user_id']}/#{project['title']}"
    unless File.directory? dir_name
        FileUtils.mkdir_p(dir_name)
    end
end

notifications = YAML.load_file("notifications.yml")
notifications.each do |notification|
    Notification.create(notification)
end