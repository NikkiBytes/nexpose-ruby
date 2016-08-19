#!/usr/bin/env ruby

require 'nexpose'


host = '10.21.99.156'
usr = 'pnac001'
pwrd = 'Coc4Col444'
port = 3780

#connect to Nexpose

nsc = Nexpose::Connection.new(host, usr, pwrd, port)
nsc.login

#sites to merge
#to_merge[x,x]
#only one -->
site = 4

#Grab assets from each site and add them
#for sites not scanned
site.each do |site_id|
  #site = Site.load(nsc, site_id)
 # unified_site.assets.concat(site.assets)

#merge based on actually scanned assets
  nsc.assets(site_id).each do |asset|
    unified_site.add_asset(asset.address)
  end
end

#will need to configure credentials, schedules, etc
unified_site.save(nsc)

#collect scan history from each site, limited to 90 days
since = (DateTime.now - 90).to_time
scans = []
site.each do |site_id|
  recent_scans = nsc.site_scan_history(site_id).select { |s| s.end_time > since }
  scans.concat(recent_scans)
end

#order chronologically
ordered = scans.sort_by { |s| s.end_time }.map { |s| s.scan_id }

puts ordered
