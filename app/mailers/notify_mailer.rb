require 'json'

class NotifyMailer < ActionMailer::Base
  def notify(user)
    @user = user
    mail :to => "info@arcwebtech.com", :from => "dashboard@arcwebtech.com", :subject => "EstimatorApp Used"
  end

  def report(user)
    @user = user
    @questions = Question.all.order(:index)

    mail :to => @user.email, :from => "dashboard@arcwebtech.com", :subject => "Thanks for using the estimator"
  end
end
