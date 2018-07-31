name             'rhnreg'
maintainer       'Duval Warren'
maintainer_email 'duvalw@gmail.com'
license          'GNU GPL v2'
description      'Installs/Configures a Spacewalk/RHN client'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.1'

%w(ubuntu redhat centos).each do |os|
  supports os
end
