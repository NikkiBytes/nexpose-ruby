#!/usr/bin/env ruby

require 'nexpose'
include Nexpose

host = '10.21.99.156'
usr = 'pnac001'
pwrd = 'Coc4Col444'
port = 3780

nsc = Connection.new(host, usr, pwrd, port)
puts 'Logging into Nexpose'
nsc.login
puts 'Logged into Nexpose'

#site_id = 4 #id for 'all servers' and 'windows server scan'


assets = Nexpose::Asset.load(nsc, 4)

vuln1 = assets.vulnerabilities[0]
asset = Asset.load(nsc, site_id)