# require_relative 'rolodex'
# require_relative 'contacts'
require 'sinatra'
require 'data_mapper'

# $rolodex= Rolodex.new
# $rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com","Rockstar"))

DataMapper.setup(:default, "sqlite3:crm.database")

class Contact
  include DataMapper::Resource

  property(:id, Serial)
  property(:first_name, String)
  property(:last_name, String)
  property(:email, String)
  property(:note, String)
end

DataMapper.finalize
DataMapper.auto_upgrade!

get '/' do
  erb(:index)
end

get "/contacts" do 
  @contacts = Contact.all
  erb(:contacts)
end

# new
get '/contacts/new' do
	erb(:new_contact)
end

# show
get "/contacts/:id" do
  @contact =  Contact.get(params[:id])
  if @contact 
    erb(:show_contact)
  else 
    raise Sinatra::NotFound
  end
end

# edit
get '/contacts/:id/edit' do
  @contact =  Contact.get(params[:id])
  if @contact 
    erb(:edit_contact)
  else 
    raise Sinatra::NotFound
  end
end

# delete

delete "/contacts/:id" do
  @contact = Contact.get(params[:id])
  if @contact
    @contact.destroy
    # $rolodex.remove_contact(@contact)
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

# update
put "/contacts/:id" do
  @contact = Contact.get(params[:id])
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]

    @contact.save
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

# create
post '/contacts' do
  new_contact = Contact.create(
  first_name: params[:first_name], 
  last_name: params[:last_name], 
  email: params[:email], 
  note: params[:note])
  redirect to('/contacts')
end
