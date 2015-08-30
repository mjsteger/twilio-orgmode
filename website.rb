require 'sinatra'
require 'haml'
require 'chronic'
require './interpret_texts'
post '/' do
  create_org_entry(params["Body"])
  puts "params are #{params}"
end
