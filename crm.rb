require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'
require "pry"

$rolodex= Rolodex.new

get '/' do
  erb(:index)
end


get "/contacts" do
  @contacts = []
  @contacts << Contact.new("Yehuda", "Katz", "yehuda@example.com", "Developer")
  @contacts << Contact.new("Mark", "Zuckerberg", "mark@facebook.com", "CEO")
  @contacts << Contact.new("Sergey", "Brin", "sergey@google.com", "Co-Founder")

  erb(:contacts)
end

get '/contacts/new' do
	erb(:new_contact)
end

post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  $rolodex.add_contact(new_contact)
  redirect to('/contacts')
end