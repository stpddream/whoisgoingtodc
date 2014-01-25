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
  end
end