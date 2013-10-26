# Change line #2 so we know which sphinx to monitor :)
appname = "md2"
run "cd #{release_path}/config;ln -sfv #{shared_path}/config/sphinx.yml ."
sudo "cd #{release_path}; rm -rf log"
run "cd #{release_path};ln -sfv #{shared_path}/log ."
run "cd #{release_path}/config;mkdir thinkingsphinx"
if node[:instance_role] == 'solo' || (node[:instance_role] == 'util' && node[:name] == 'Utility')
  run "cd #{release_path} pkill -f 'searchd' && rake thinking_sphinx:configure && bundle exec rake thinking_sphinx:index && bundle exec rake thinking_sphinx:running_start"
  sudo "monit monitor sphinx_#{appname}_3312"
else
  run "cd #{release_path} bundle exec rake thinking_sphinx:configure"
end
