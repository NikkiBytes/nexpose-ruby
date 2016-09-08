#!\usr\bin\env ruby

require 'nexpose'
include Nexpose

host = xxxxx
usr = xxxxx
pass = xxxxx
port = 3780

nsc =  Connection.new(host, usr, pass, port)
nsc.login

	
#get list of VULNERABILITY DEFINITIONS by title (500 LIMIT)
vulnDefs = nsc.find_vulns_by_title('xxx') 

#get individual vuln ID									
vulnID = a[x].id 

#get details of individual  vuln 
dets = nsc.vuln_details(vulnID) 

#initialize title array 
xxxTitles = Array.new

#filter titles/add to array 
for x in vulnDefs
  a = x.title
  if a.include? 'xxxx' #filter 
    xxxTitles << a
  end
end
    
#write to file
File.open('xxxx.txt', 'w') do |f| 
  ms16_titlesA.each { |e| f.puts(e)}
 end
 
