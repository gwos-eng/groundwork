template "/etc/sysctl.conf" do
        source "sysctl.conf.erb"
        owner "root"
        mode "0644"
end

remote_file "/home/ubuntu/#{node["groundwork"]["file_name"]}" do
        source node["groundwork"]["build_url"]
        mode "0644"
        action :create_if_missing
end
