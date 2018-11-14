require "jars/installer"

desc "Install and vendor jars"
task :vendor do
  Jars::Installer.vendor_jars!
end
