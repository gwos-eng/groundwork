template "/etc/sysctl.conf" do
        source "sysctl.conf.erb"
        owner "root"
        mode "0644"
end

ruby_block "create variables" do
    block do
        edition = "groundworkenterprise"
        s3_location = `s3cmd ls s3://Groundwork/ |grep ${edition}- |tail -1 |awk \'{print $4}\'`
        node.set["groundwork"]["file_name"] = s3_location.split('/')[3].gsub("\n","")
        node.set["groundwork"]["build_url"] = "https://s3.amazonaws.com/Groundwork/" + node["groundwork"]["file_name"]
    end
    action :create
    notifies :create_if_missing, "remote_file[Groundwork File]"
end

remote_file "Groundwork File" do
    path "/home/ubuntu/#{node["groundwork"]["file_name"]}"
    source node["groundwork"]["build_url"]
    mode "0644"
    action :nothing
end
