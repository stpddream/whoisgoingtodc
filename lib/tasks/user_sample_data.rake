namespace :db do
  desc "Fill User table with sample data"
  task populate: :environment do
    
    status_strs = ["on shelf", "unavailable"]
    year_strs = (1970..2070).to_a
    50.times do
      name = Faker::Name.name
      email = Faker::Internet.email
      password = Faker::Internet.password
      
      
      User.create!(email: email, name: name, password: password, password_confirmation: password)
      
    end
    
    User.create!(email: "fxiong@haverford.edu", name: "Panda", password: "111111", password_confirmation: "111111")
    make_friends
  end
end

def make_friends
  panda = User.find_by_email("fxiong@haverford.edu")
  people = User.all[2..15]
  people.each { |person| 
    panda.friend!(person) 
    puts person.name
    puts "hahahah"
  }
  
end