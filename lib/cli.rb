require_relative 'scraper.rb'
require_relative 'user.rb'

class CLI
  def start
    User.load_users_from_file # Loads users from file
    Scraper.scrape_countries
    puts "Welcome to the Countries of the World CLI!"
    authenticate
    #puts "What is your name?"
    #name = gets.strip  # get user's input and remove white space
    #puts "Hello #{name}!"
    puts "Please enter a country name to learn more about it."
    input = gets.strip
    country = Country.all.find {|c| c.name.downcase == input.downcase}
    if country === nil
      puts "Sorry, that country is not in our database."
    else
      puts "Name: #{country.name}"
      puts "Capital: #{country.capital}"
      puts "Population: #{country.population}"
      puts "Area: #{country.area}"
    end
  end

  def get_input
    gets.strip
  end

  # authenticate user or create account
    def authenticate
      authenticated = false

      until authenticated
        puts 'Please login or sign up'
        puts 'Which do you choose? (sign up/login)'

        if get_input == 'login'
          authenticated = login
        else
          create_account
        end
      end
    end

    # check if user is in User class and if password matches
    def login
      puts 'Please enter your username:'
      username = gets.chomp
      puts 'Please enter your password:'
      password = gets.chomp
      result = User.authenticate(username, password)

      if result
        puts "Welcome back #{username}!"
      else
        puts 'Sorry, username and password combination is not recognized. Please try again.'
      end
      result
    end

    # create a new user and add to User class
    def create_account
      puts 'Please enter a username:'
      username = gets.chomp

      puts 'Please enter a password:'
      password = gets.chomp

      user = User.new(username, password, false) # false indicates that the password is not hashed.
      User.store_credentials(user)
      puts 'Account created'
    end
end
