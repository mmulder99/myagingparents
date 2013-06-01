require 'rubygems'
require 'twilio-ruby' # Download twilio-ruby from twilio.com/docs/libraries
 
# Get your Account Sid and Auth Token from twilio.com/user/account 
account_sid = 'AC32a3c49700934481addd5ce1659f04d2'
auth_token = '{{ auth_token }}'
@client = Twilio::REST::Client.new account_sid, auth_token
 
message = @client.account.sms.messages.create(:body => "Jenny please?! I love you <3",
    :to => "+14159352345",
    :from => "+14158141829")
puts message.sid