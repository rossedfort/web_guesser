require 'sinatra'
require 'sinatra/reloader'
require 'pry'

@@SECRET_NUMBER = rand(100)
@@count = 5

def secret_number
  @@SECRET_NUMBER
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

def guesses(guess)
  if guess.nil?
    ""
  elsif @@count > 1 && guess.to_i != secret_number
    @@count -= 1
    "You have #{@@count} tries left"
  elsif @@count > 0 && guess.to_i == secret_number
    @@count = 5
    @@SECRET_NUMBER = rand(100)
    "You guessed correctly :D\nA new number has been generated."
  elsif @@count == 1 && guess.to_i != secret_number
    @@count = 5
    @@SECRET_NUMBER = rand(100)
    "Too many tries :(\nA new number has been generated"
  end
end


get '/' do
  guess = params["guess"]
  @@message = check_guess(guess)
  @@counter = guesses(guess)
  erb :index, :locals => {:number => @@SECRET_NUMBER,
                          :message => @@message,
                          :color => @color,
                          :counter => @@counter
                        }
end
