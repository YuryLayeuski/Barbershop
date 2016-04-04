require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def get_db
	db = SQLite3::Database.new 'barbershop.db'
	db.results_as_hash = true
	return db
end

configure do
	db = get_db
	db.execute 'CREATE  TABLE IF NOT EXISTS
		 "Users" 
		 (
		 	"id" INTEGER PRIMARY KEY AUTOINCREMENT,
		 	 "username" TEXT,
		 	 "phone" TEXT,
		 	 "datestamp" TEXT,
		 	 "barber" TEXT,
		 	 "color" TEXT
		 )'
end


get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

post '/visit' do

	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	hh = { :username => 'Enter name', 
			:phone => 'Enter phone number', 
			:datetime => 'Enter date and time' }

hh.each do |key, value|
	#if parametr is empty
	if params[key] == ''
			#than variable 'error' assign value from hash 'hh'
			#(value from hash hh is message about error)
			#variable error assign message about error
			@error = hh[key]
			#return visit 
			return erb :visit
	end
end

	db = get_db
	db.execute 'INSERT INTO
		 Users 
		 (
		 	username,
		 	phone,
		 	datestamp,
		 	barber,
		 	color
		 )
		 values ( ?, ?, ?, ?, ? )', [@username, @phone, @datetime, @barber, @color]

	erb "OK!, username is #{@username}, #{@phone}, Your date is #{@datetime}, Your barber is: #{@barber}, #{@color}"
end

get '/showusers' do
  erb :"Hello World"
end












