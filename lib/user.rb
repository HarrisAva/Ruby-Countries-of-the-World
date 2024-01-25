require "bcrypt"
require 'json'

class User
  attr_accessor :username, :password

  @@users = []
  def initialize(username, password, password_pre_hashed = false)
    @username = username
    @password = password_pre_hashed ? BCrypt::Password.new(password) : 
 BCrypt::Password.create(password) 
    # if password_pre_hashed is true, create a new password object from the pre-hashed password. If not, create a new password object from the password argument.
    #store_credentials(self) # store the user in the users.json file
    @@users << self # adds the new user to the @@users array
  end

  def self.authenticate(username, password)
    user = User.find_by_username(username)

    if user && user.password == password
      return user
    else
      return nil
    end
  end

  def self.all # returns all users
    @@users
  end

  def self.find_by_username(username)
    user = all.find do |user|
      user.username == username
    end
    user
  end

  def self.store_credentials(user)
    file_path = 'users.json'

    unless File.exist?(file_path) # if the file_path exists, use that file. if not, create it
      File.open(file_path, 'w') { |file| file.write(JSON.generate([]))} # create an empty array of JSON file.
    end

    file = File.read(file_path) # read the file
    users_data = JSON.parse(file) # parse the JSON string into an array of hashes

    users_data << { 'username' => user.username, 'password' => user.password } # add the new user to the array of hashes
    
    File.open(file_path, 'w') { |file| file.write(JSON.generate(users_data))} # write the updated array of hashes to the file'}
  end


  # Once we check to see if the file exists, we will read the file and parse the JSON string into an array. We will then add the user's username and password to the array and write the array back to the file.
  def self.load_users_from_file
    file_path = 'users.json' # the path to the Json file

    if File.exist?(file_path) # if the file exists, read the file 
      file = File.read(file_path) # read the file
      users_data = JSON.parse(file)

      users_data.each do |user_data| # iterate over each user in the array
        User.new(user_data['username'], user_data['password'], true) # true indicates the password is already hashed
      end
    end
  end
end