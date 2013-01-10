template "/etc/sysctl.conf" do
        source "sysctl.conf.erb"
        owner "root"
        mode "0644"
end

edition = "groundworkenterprise"
node.set["groundwork"]["s3_location"] = `s3cmd ls s3://Groundwork/ |grep ${edition}- |tail -1 |awk \'{print $4}\'`
if File.exists?('/home/ubuntu/.s3cfg')
	node.set["groundwork"]["file_name"] = node["groundwork"]["s3_location"].split('/')[3].gsub("\n","")
end

remote_file "/home/ubuntu/#{node["groundwork"]["file_name"]}" do
        source node["groundwork"]["build_url"] + node["groundwork"]["file_name"] 
        mode "0644"
        action :create_if_missing
end
