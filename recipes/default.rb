#
# Cookbook Name:: groundwork
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash "install groundwork" do
	not_if { File.exists?('/usr/local/groundwork') }
	user "root"
	cwd "/home/ubuntu"
	code <<-EOH
		chmod +x #{file_name}
		./#{file_name} --mode unattended --postgres_password 123
	EOH
end

template "/usr/local/groundwork/config/resources/josso-agent-config.xml" do
	source "josso-agent-config.xml.erb"
	owner "root"
	mode "0644"
	variables(
		:public_hostname	=> node['ec2']['public_hostname']
	)
end

execute "/etc/init.d/groundwork restart gwservices" do
	action :run
end
