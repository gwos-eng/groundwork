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
        node.set["gourndowkr"]["build_url"] = "https://s3.amazonaws.com/Groundwork/" + file_name
    end
    action :create
end

remote_file "/home/ubuntu/#{node["groundwork"]["file_name"]}" do
    source node["groundwork"]["build_url"]
    mode "0644"
    action :create_if_missing
end


