if node[:name] == 'Utility'
  cron "index" do
    minute  '*/15'
    user    'deploy'
    command "cd /data/md2/current && sudo rake ts:index RAILS_ENV=production"
  end
end