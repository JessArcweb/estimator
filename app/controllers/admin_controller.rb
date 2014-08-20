class AdminController < ApplicationController
  def index
    @questions = Question.all
  end

  def dump_csv
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
    @users = User.all

      Tempfile.open(["report",".csv"]) do |t|
        t << "Name".csv_safe
        t << "Email".csv_safe
        answer = "Answer 1"
        (0..@questions.length-1).each do |i|
          t << "#{answer}".csv_safe
          answer = answer.next
        end
        t << "\n"
        t << "0".csv_safe
        t << "0".csv_safe
        @questions.each do |q|
          t << "#{q["body"]}".csv_safe
        end
        t << "\n"
        @users.each do |u|
          t << u.name.csv_safe
          t << u.email.csv_safe

          u.answers.each do |a|
            t << "#{a}".csv_safe
          end
          t << "\n"
        end

        send_file t, {filename:"dump.csv"}
      end
  end
end

class String
  include ActionView::Helpers::NumberHelper
  def csv_safe(currency = false)
    self.gsub!("\"","\"\"")
    return "\"" + self + "\"," unless currency
    return "\"" + number_to_currency(self.to_f) + "\","
  end
end
