require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def is_barber_exists? db, name
	db.execute('select * from Barbers where name=?', [name]).length > 0
end

def seed_db db, barbers 
	barbers.each do |barber|
		if !is_barber_exists? db, 
			db.execute 'insert into Barbers (name) values (?)', [barber]
		end
	end
end

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

		 db.execute 'CREATE  TABLE IF NOT EXISTS
		 "Barbers" 
		 (
		 	"id" INTEGER PRIMARY KEY AUTOINCREMENT,
		 	 "name" TEXT
		 )'

		 seed_db db, ['Jessie Pinkman', 'Mike Johnson', 'Gus Frik', 'Hector Salamon']
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
	db = get_db

	@results = db.execute 'select * from Users order by id desc'
	
	erb :showusers
end












