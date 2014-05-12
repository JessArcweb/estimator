class NotifyMailer < ActionMailer::Base
  def notify(user)
    @user = user
    mail :to => "mroll@arcwebtech.com", :from => "mroll@arcwebtech.com", :subject => "EstimatorApp Used"
  end
end
