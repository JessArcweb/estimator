class User < ActiveRecord::Base
  validates :name, :email, presence: true
  serialize :answers
end
