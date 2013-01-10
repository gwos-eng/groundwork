template "/etc/sysctl.conf" do
        source "sysctl.conf.erb"
        owner "root"
        mode "0644"
end

edition = "groundworkenterprise"
node.set["groundwork"]["s3_location"] = `s3cmd ls s3://Groundwork/ |grep ${edition}- |tail -1 |awk \'{print $4}\'`

remote_file "/home/ubuntu/#{node["groundwork"]["file_name"]}" do
	if File.exists?('/home/ubuntu/groundwork.run')
		node.set["groundwork"]["build_url"] += node["groundwork"]["s3_location"].split('/')[3].gsub("\n","")
	end
        source node["groundwork"]["build_url"] 
        mode "0644"
        action :create_if_missing
end
