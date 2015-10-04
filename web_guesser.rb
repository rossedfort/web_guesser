require 'sinatra'
require 'sinatra/reloader'
require 'pry'

SECRET_NUMBER = rand(100)

def secret_number
  SECRET_NUMBER
end

def check_guess(guess)
  guess = guess.to_i unless guess.nil?
  too_high = secret_number + 5
  too_low = secret_number - 5
  if guess.nil?
    @color = "#FFFFFF"
    "Guess!"
  elsif guess > too_high
    @color = "#FF3300"
    "Wayyyy Too high!"
  elsif guess < too_low
    @color = "#FF3300"
    "Wayyyy Too low!"
  elsif guess < secret_number
    @color = "#FF6600"
    "Too Low!"
  elsif guess > secret_number
    @color = "#FF6600"
    "Too High!"
  else
    @color = "#00FF00"
    "Got it! -- The Secret Number is #{secret_number}"
  end
end

# def color_changer
#   if @@message == "Guess!"
#     "background-color:#FFFFFF"
#   elsif @@message == "Wayyyy Too high!" || "Wayyyy Too low!"
#     "background-color:#FF3300"
#   elsif @@message == "Too High!" || "Too Low!"
#     "background-color:#FF6600"
#   elsif @@message == "Got it! -- The Secret Number is #{secret_number}"
#     "background-color:#00FF00"
#   end
# end

get '/' do
  guess = params["guess"]
  @@message = check_guess(guess)
  erb :index, :locals => {:number => SECRET_NUMBER,
                          :message => @@message,
                          :color => @color
                        }
end
