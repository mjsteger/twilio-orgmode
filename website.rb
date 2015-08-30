require 'sinatra'
require 'haml'
require 'chronic'
require './interpret_texts'
post '/' do
  TextInterpreter.new.interpret_text(params["Body"])
  puts "params are #{params}"
end
