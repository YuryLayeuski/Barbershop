require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

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

	erb "OK!, username is #{@username}, #{@phone}, Your date is #{@datetime}, Your barber is: #{@barber}, #{@color}"

end











