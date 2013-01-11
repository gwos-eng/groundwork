template "/etc/sysctl.conf" do
        source "sysctl.conf.erb"
        owner "root"
        mode "0644"
end

#remote_file "/home/ubuntu/#{node["groundwork"]["file_name"]}" do
#    if File.exists?('/home/ubuntu/.s3cfg')
#        edition = "groundworkenterprise"
#        s3_location = `s3cmd ls s3://Groundwork/ |grep ${edition}- |tail -1 |awk \'{print $4}\'`
#        build_url = "https://s3.amazonaws.com/Groundwork/" + s3_location.split('/')[3].gsub("\n","")
#    end
#    source build_url
#    mode "0644"
#    action :create_if_missing
#end

bash "download gwos" do
    if File.exists?('/home/ubuntu/.s3cfg')
        edition = "groundworkenterprise"
        s3_location = `s3cmd ls s3://Groundwork/ |grep ${edition}- |tail -1 |awk \'{print $4}\'`
        file_name = s3_location.split('/')[3].gsub("\n","")
        build_url = "https://s3.amazonaws.com/Groundwork/" + file_name
    end
    not_if File.exists?('/home/ubuntu/#{file_name}')
    user "ubuntu"
    cwd '/home/ubuntu'
    code <<-EOH
        wget #{build_url}
    EOH
end
