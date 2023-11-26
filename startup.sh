#!/binbash

# Setup last flag
gcc boiuna.c -o ../boiuna
rm boiuna.c
rm Dockerfile

# Start Web Server

bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed

thin -e production -a 0.0.0.0 -p 8443 --threaded start