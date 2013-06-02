class Account < ActiveRecord::Base
  validates_format_of :phone, :with => /^\+?\d+(-\d+)*$/, :message => " Number is invalid"
  
  attr_accessible :phone
end
