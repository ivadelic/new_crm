require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'
require 'pry'

$rolodex= Rolodex.new
$rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com","Rockstar"))

get '/' do
  erb(:index)
end

# index
get "/contacts" do
  @contacts = $rolodex.contacts
  erb(:contacts)
end

# new
get '/contacts/new' do
	erb(:new_contact)
end

# create
post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  $rolodex.add_contact(new_contact)
  redirect to('/contacts')
end

# show
get "/contacts/:id" do
	@contact = $rolodex.find(params[:id])
	if @contact 
		erb(:show_contact)
	else 
		raise Sinatra::NotFound
	end
end

# edit
get '/contacts/:id/edit' do
  @contact = $rolodex.find(params[:id])
	if @contact 
		erb(:edit_contact)
	else 
		raise Sinatra::NotFound
	end
end

# update
put "/contacts/:id" do
  @contact = $rolodex.find(params[:id])
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]

    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

# delete



