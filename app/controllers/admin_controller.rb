class AdminController < ApplicationController
  def index
    @questions = Question.all
  end

  def dump_csv
    @questions = Question.all.order(:index)
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
          t << "#{q[:body]}".csv_safe
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
