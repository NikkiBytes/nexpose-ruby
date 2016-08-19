#!/usr/bin/env ruby

#Purpose: write report on OS vulnerability scans

require 'nexpose'
require 'rubygems'
require 'pp'
#require 'time'
#require 'highline/import'
include Nexpose

default_host = '10.21.99.156' #Nexpose IP address
default_port = 3780
default_user = 'pnac001' #fill in username
default_file = 'OSVulnerabilities_' + DateTime.now.strftime('%Y-%m-%d--%H%M') + '.csv'
default_pass = 'Coc4Col444' #fill in password

#information passed to connection object 
nsc = Nexpose::Connection.new(default_host, default_user, default_pass, default_port)
puts 'Logging into Nexpose.'
nsc.login
puts 'Logged into Nexpose'


#get a list of vulnerabilities by date
recent_vulns = nsc.find_vulns_by_date('2016-08-01', '2016-08-18')
vuln_ids = []
recent_vulns.each do |v|
  vulns_ids += nsc.find_vuln_check(v.title).map { |c| c.check_id }
end


#filter assests based on criteria
#assets = @nsc.filter(Search::Field::OS, Search::Operator::CONTAINS, 'Microsoft')
#puts assets

template = ScanTemplate.load(nsc)
template.name = 'Now'
template.description = 'Vulnerability scan against vulnerability checks'
vuln_ids.uniq.each do |vuln|
  template.enable_vuln_check(vuln)
end
template.web_spidering = false
template.policy_scanning = false
template.save(nsc)

site = Site.load(nsc, 4)
site.scan_template_id = template.id
site.save(nsc)
site.scan(nsc)