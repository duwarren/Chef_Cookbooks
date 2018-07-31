platform_major = node['platform_version'][0]
platform_dist = node['platform']
my_name = node['hostname']
#clever snippet so just commenting it out
#cpu_count = node['cpu']['total']
unregistered = '/etc/sysconfig/rhn/unregistered'
registered = '/etc/sysconfig/rhn/systemid'
package 'sshpass'
#Registration Logic(science bitches!)
#
if platform_dist == "centos" && platform_major == "5"
#Register Centos5 servers
  execute 'c5register-with-spacewalk-server' do
    command "rhnreg_ks --activationkey=#{node['spacewalk']['reg']['key1']} --serverUrl=#{node['spacewalk']['reg']['server2']}/XMLRPC && yum -y update --disablerepo="
    not_if { File.exist?(registered) }
  end
elsif platform_dist == "centos" && platform_major == "6"
#Register Centos6 servers
  execute 'c6register-with-spacewalk-server' do
    command "rhnreg_ks --activationkey=#{node['spacewalk']['reg']['key2']} --serverUrl=#{node['spacewalk']['reg']['server2']}/XMLRPC && yum -y update --disablerepo="
    not_if { File.exist?(registered) }
  end
elsif platform_dist == "centos" && platform_major == "7"
#Register Centos7 servers
  execute 'c7register-with-spacewalk-server' do
    command "rhnreg_ks --activationkey=#{node['spacewalk']['reg']['key3']} --serverUrl=#{node['spacewalk']['reg']['server2']}/XMLRPC && yum -y update --disablerepo="
    not_if { File.exist?(registered) }
  end
elsif platform_dist == "redhat" && platform_major == "5"

#Register redhat5 servers with base repo
  execute 'r5register-with-satellite-server_base' do
    command "rhnreg_ks --activationkey=#{node['spacewalk']['reg']['key7']} --serverUrl=#{node['spacewalk']['reg']['server1']}/XMLRPC && yum -y update --disablerepo="
    not_if { File.exist?(registered) }
  end
#Unregister from redhat5 base repo
  execute 'r5de_register-with-satellite-server' do
    command %Q{
      sleep 20
      sshpass -p '' ssh -o StrictHostKeyChecking=no user@#{node['spacewalk']['reg']['node1']} /usr/bin/spacecmd clear_caches -u -p ''
      sleep 20
      sshpass -p '' ssh -o StrictHostKeyChecking=no user@#{node['spacewalk']['reg']['node1']} /usr/bin/spacecmd system_delete -y #{my_name} -u  -p ''
      rm -rf /etc/sysconfig/rhn/systemid
      touch /etc/sysconfig/rhn/unregistered
    } 
    not_if { File.exist?(unregistered) }
  end
#Register with redhat5 update channels and update security only
  execute 'r5register_with_update_channels' do
    command %Q{
     yum clean all
     rhnreg_ks --activationkey=#{node['spacewalk']['reg']['key4']} --serverUrl=#{node['spacewalk']['reg']['server1']}/XMLRPC && /usr/bin/yum update-minimal --security -y --disablerepo=
     }
    not_if { File.exist?(registered) }
  end
elsif platform_dist == "redhat" && platform_major == "6"

#Register redhat6 servers with base repo
  execute 'r6register-with-satellite-server_base' do
    command  %Q{
      rhnreg_ks --activationkey=#{node['spacewalk']['reg']['key8']} --serverUrl=#{node['spacewalk']['reg']['server1']}/XMLRPC && yum -y update --disablerepo=
    }
    not_if { File.exist?(registered) }
  end
#Unregister from redhat6 base repo
  execute 'r6de_register-with-satellite-server' do
    command %Q{
      sshpass -p '' ssh -o StrictHostKeyChecking=no user@#{node['spacewalk']['reg']['node1']} /usr/bin/spacecmd clear_caches -u duwarren -p ''
      sleep 10
      sshpass -p '' ssh -o StrictHostKeyChecking=no user@#{node['spacewalk']['reg']['node1']} /usr/bin/spacecmd system_details #{my_name} -u -p ''
      sshpass -p '' ssh -o StrictHostKeyChecking=no user@#{node['spacewalk']['reg']['node1']} /usr/bin/spacecmd system_delete -y #{my_name} -u -p ''
      sleep 10
      sshpass -p '' ssh -o StrictHostKeyChecking=no user@#{node['spacewalk']['reg']['node1']} /usr/bin/spacecmd system_list -u -p ''
      rm -rf /etc/sysconfig/rhn/systemid
      touch /etc/sysconfig/rhn/unregistered
    }
    not_if { File.exist?(unregistered) }
end
#Register with redhat6 updaate channels and update security only
  execute 'r6register-with-satellite-server_updates' do
    command %Q{
      sleep 10
      yum clean all
      rhnreg_ks --activationkey=#{node['spacewalk']['reg']['key5']} --serverUrl=#{node['spacewalk']['reg']['server1']}/XMLRPC && /usr/bin/yum update-minimal --security -y --disablerepo=
      }
    not_if { File.exist?(registered) }
  end
elsif platform_dist == "redhat" && platform_major == "7"
#Register redhat7 servers
  execute 'r7register-with-satellite-server_base' do
    command "rhnreg_ks --activationkey=#{node['spacewalk']['reg']['key9']} --serverUrl=#{node['spacewalk']['reg']['server1']}/XMLRPC && yum -y update --disablerepo="
    not_if { File.exist?(registered) }
  end

#Unregister from redhat7 base repo
  execute 'r7de_register-with-satellite-server' do
    command %Q{
      sshpass -p '' ssh -o StrictHostKeyChecking=no user@#{node['spacewalk']['reg']['node1']} /usr/bin/spacecmd clear_caches -u -p ''
      sleep 10
      sshpass -p '' ssh -o StrictHostKeyChecking=no user@#{node['spacewalk']['reg']['node1']} /usr/bin/spacecmd system_details #{my_name} -u -p ''
      sshpass -p '' ssh -o StrictHostKeyChecking=no user@#{node['spacewalk']['reg']['node1']} /usr/bin/spacecmd system_delete -y #{my_name} -u -p ''
      sleep 10
      sshpass -p '' ssh -o StrictHostKeyChecking=no user@#{node['spacewalk']['reg']['node1']} /usr/bin/spacecmd system_list -u -p ''
      rm -rf /etc/sysconfig/rhn/systemid 
      touch /etc/sysconfig/rhn/unregistered
    }
    not_if { File.exist?(unregistered) }
  end
#Register with redhat7 update channels and update security only
  execute 'r7register-with-satellite-server_updates' do
    command %Q{
      yum clean all
      rhnreg_ks --activationkey=#{node['spacewalk']['reg']['key6']} --serverUrl=#{node['spacewalk']['reg']['server1']}/XMLRPC && /usr/bin/yum update-minimal --security -y --disablerepo=
      }
  not_if { (File.exist?('/etc/sysconfig/rhn/systemid')) }
  end
end
