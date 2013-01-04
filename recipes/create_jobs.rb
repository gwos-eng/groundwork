include_recipe "jenkins"

clean_install = File.join(File.dirname(File.expand_path(__FILE__)) + '/../jenkins_config', "clean_install_config.xml")
download_groundwork = File.join(File.dirname(File.expand_path(__FILE__)) + '/../jenkins_config/', "download_config.xml")
groundwork_chef = File.join(File.dirname(File.expand_path(__FILE__)) + '/../jenkins_config/', "groundwork_chef_config.xml")
gwos_daily = File.join(File.dirname(File.expand_path(__FILE__)) + '/../jenkins_config/',"GWOS_daily_config.xml")
gwos_regression = File.join(File.dirname(File.expand_path(__FILE__)) + '/../jenkins_config/', "GWOS_regression_config.xml")
smoke_test = File.join(File.dirname(File.expand_path(__FILE__)) + '/../jenkins_config/', "GWOS_smoketest_config.xml")
gwos_upgrade = File.join(File.dirname(File.expand_path(__FILE__)) + '/../jenkins_config/', "GWOS_upgrade_config.xml")
upload_s3 = File.join(File.dirname(File.expand_path(__FILE__)) + '/../jenkins_config/', "upload_s3_config.xml")

jenkins_job "Clean Install GWOS" do
	action [:create, :update]
	config clean_install
end

jenkins_job "Download GWOS" do
	action [:create, :update]
	config download_groundwork
end

jenkins_job "GWOS Daily Test" do
	action [:create, :update]
	config gwos_daily
end

jenkins_job "GWOS Regression Test" do
	action [:create, :update]
	config gwos_regression
end

jenkins_job "GWOS Smoke Test" do
	action [:create, :update]
	config smoke_test
end

jenkins_job "GWOS Upgrade Test" do
	action [:create, :update]
	config gwos_upgrade
end
