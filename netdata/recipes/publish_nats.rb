cookbook_file '/usr/local/bin/nats-pub' do
  source 'nats-pub'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cron 'publish_to_nats' do
  command "/usr/local/bin/nats-pub -s #{node['metrichill']['nats']} 'router.register' '{\"host\":\"#{node['metrichill']['register_ip']}\",\"port\":19999,\"uris\":[\"#{node['netdata']['backend']['hostname']}-#{node['opsworks']['stack']['name']}.#{node['metrichill']['domain']}\"],\"tags\":{\"name\":\"#{node['netdata']['backend']['hostname']}\",\"stack\":\"#{node['opsworks']['stack']['name']}\",\"layers\":\"#{node['opsworks']['instance']['layers'].join('::')}\" }}'"
end
