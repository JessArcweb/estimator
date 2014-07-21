require 'json'

class NotifyMailer < ActionMailer::Base
  def notify(user)
    @user = user
    mail :to => "mroll@arcwebtech.com", :from => "mroll@arcwebtech.com", :subject => "EstimatorApp Used"
  end

  def report(user)
    @user = user
    @questions = [
      { "body" => "How many platforms (iOS, Android, Mobile Web)?",
        "choices"=> { "1"=> 100000, "2"=> 175000, "3"=> 225000 } },
      { "body"=> "Will your app need photo library access?",
        "choices"=> { "Yes"=> 5000, "No"=> 0 } },
      { "body"=> "Will your app need GPS access?",
        "choices"=> { "Yes"=> 5000, "No"=> 0 } },
      { "body"=> "Will your app integrate a legacy system?",
        "choices"=> { "Yes"=> 25000, "No"=> 0 } },
      { "body"=> "What level of security will your app have?",
        "choices"=> { "None"=> 0, "Bank-like"=> 25000 } },
      { "body"=> "Will your app support credit card payment?",
        "choices"=> { "Yes"=> 0, "No"=> 0 } },
      { "body"=> "Will your app integrate SalesForce CRM?",
        "choices"=> { "Yes"=> 25000, "No"=> 0 } },
      { "body"=> "Will your app function offline?",
        "choices"=> { "Yes"=> 20000, "No"=> 0 } },
      { "body"=> "How many ways will users be able to sign in (Twitter, Facebook, LinkedIn, Google)?",
        "choices"=> { "1"=> 5000, "2"=> 10000, "3"=> 15000, "4"=> 20000, "No sign in"=> 0 } },
      { "body"=> "Will your app support an MVP or polished design?",
        "choices"=> { "Polished"=> 50000, "MVP"=> 25000 } }
    ] 
    @questions = JSON.parse(@questions.to_json)
    puts @questions[0]["body"]
    mail :to => "mroll@arcwebtech.com", :from => "mroll@arcwebtech.com", :subject => "Thanks for using the estimator"
  end
end
