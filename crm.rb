require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

$rolodex= Rolodex.new
@@rolodex= Rolodex.new
@@rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com","Rockstar"))

get '/' do
  erb(:index)
end


get "/contacts" do
  @contacts = []
  erb(:contacts)
end

get "/contacts/:id" do
	@contact = @@rolodex.find(1000)
	erb :show_contact
end

get '/contacts/new' do
	erb(:new_contact)
end

post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  @@rolodex.add_contact(new_contact)
  redirect to('/contacts')
end