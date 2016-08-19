#!/usr/bin/env ruby

require 'nexpose'
include Nexpose

host = '10.21.99.156'
usr = 'pnac001'
pwrd = 'Coc4Col444'
port = 3780

nsc = Connection.new(host, usr, pwrd, port)
nsc.login



site_id = 4

site = Site.load(nsc, site_id)

scans = nsc.site_scan_history(site_id).sort_by { |s| s.end_time }.map { |s| s.scan_id}
#puts scans
filename = "test.csv"



report = Nexpose::AdhocReportConfig.new('test','csv')
date = report.generate(nsc, 4)
file = File.open(filename, "w"){|file|file.write(data)}
nsc.logout
exit
file.write(scans)