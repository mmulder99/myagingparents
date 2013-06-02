class Account < ActiveRecord::Base
  validates :phone, format: { with: /^\+?\d+(-\d+)*$/ }
  
  attr_accessible :phone
end
