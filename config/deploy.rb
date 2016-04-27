# -*- encoding : utf-8 -*-
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :domain, '127.0.0.1'
set :user, 'root'
set :deploy_to, '/home/rails'
set :repository, 'git@repot-name/APPNAME.git'
set :branch, 'master'
set :rvm_path, '/usr/local/rvm/bin/rvm'
set :ssh_flags, "-l root"
set :shared_paths, ['config/database.yml', 'log']

task :environment do
  invoke :'rvm:use[2.1.3@APPNAME]'
end

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]
  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]
  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue! %[mkdir -p "#{deploy_to}/shared/public/system"]

end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

     to :launch do
      queue! '/etc/init.d/unicorn restart'
      queue! '/etc/init.d/nginx restart'
      queue! 'rm -f /home/rails/current/public/system/'
      queue! "ln -s /home/rails/shared/public/system/ /home/rails/current/public/"
     end
  end
end
