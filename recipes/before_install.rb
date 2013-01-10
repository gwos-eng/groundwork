template "/etc/sysctl.conf" do
        source "sysctl.conf.erb"
        owner "root"
        mode "0644"
end

edition = "groundworkenterprise"
groundwork_version = `s3cmd ls s3://Groundwork/ |grep ${edition}- |tail -1 |awk \'{print $4}\'`
file_name = groundwork_version.split('/')[3]
file_name = file_name.gsub("\n","")

remote_file "/home/ubuntu/#{file_name}" do
        source node["groundwork"]["build_url"] + file_name
        mode "0644"
        action :create_if_missing
end
