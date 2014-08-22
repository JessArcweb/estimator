# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Question.create([{
  :body => "How many platforms will your app support (iOS, Android, Mobile Web)?", 
  :choices_attributes => [{:option => "1", :value => 100000}, {:option => "1", :value => 175000}, {:option => "1", :value => 225000}]
}])

Question.create([{
  :body => "Will your app need photo library access?", 
  :choices_attributes => [{:option => "Yes", :value => 5000}, {:option => "No", :value => 0}]
}])

Question.create([{
  :body => "Will your app need GPS access?", 
  :choices_attributes => [{:option => "Yes", :value => 5000}, {:option => "No", :value => 0}]
}])

Question.create([{
  :body => "What kind of security will your app support?", 
  :choices_attributes => [{:option => "Bank-like", :value => 25000}, {:option => "None", :value => 0}]
}])

Question.create([{
  :body => "Will your app support credit card payment?", 
  :choices_attributes => [{:option => "Yes", :value => 12000}, {:option => "No", :value => 0}]
}])

Question.create([{
  :body => "Will your app integrate a legacy system?", 
  :choices_attributes => [{:option => "Yes", :value => 25000}, {:option => "No", :value => 0}]
}])

Question.create([{
  :body => "Will your app integrate SalesForce CRM?", 
  :choices_attributes => [{:option => "Yes", :value => 25000}, {:option => "No", :value => 0}]
}])

Question.create([{
  :body => "Will your app function offline?", 
  :choices_attributes => [{:option => "Yes", :value => 20000}, {:option => "No", :value => 0}]
}])

Question.create([{
  :body => "How many ways will users be able to sign in (Twitter, Facebook, LinkedIn, Google)?", 
  :choices_attributes => [{:option => "1", :value => 5000}, {:option => "2", :value => 10000}, {:option => "3", :value => 15000}, {:option => "4", :value => 20000}]
}])

Question.create([{
  :body => "Will your app support an MVP or a Polished design?", 
  :choices_attributes => [{:option => "Polished", :value => 50000}, {:option => "MVP", :value => 25000}]
}])
