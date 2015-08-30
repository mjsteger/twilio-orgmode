require 'sinatra'
require 'haml'
require 'chronic'

post '/' do
  create_org_entry(params["Body"])
  puts "params are #{params}"
end

def create_org_entry(text)
  text, date = text.split("-")
  date = date ? Chronic.parse(date) : Time.now
  formatted_date = date.strftime("%Y-%m-%d %a")
  full_payload = "
* TODO #{text}
SCHEDULED: <#{formatted_date}>"
  File.open('/home/steggy/Dropbox/national/dropbox-notes.org', 'a+') { |f| f.write(full_payload)}
end
