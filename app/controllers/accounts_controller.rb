class AccountsController < ApplicationController
  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @account = Account.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/new
  # GET /accounts/new.json
  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/1/edit
  def edit
    @account = Account.find(params[:id])
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(params[:account])

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render json: @account, status: :created, location: @account }
      else
        format.html { render action: "new" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accounts/1
  # PUT /accounts/1.json
  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :no_content }
    end
  end
  
  def took_walk
    @id = params[:id]

    accounts = Account.find(@id)
    send_sms(accounts.phone, "Going for walk.")
     
    flash[:notice] = "Successfully sent took walk message to junior" 
     
    redirect_to :controller => "accounts", :action => "show", :id => @id and return
  end
  
  def took_meds
    @id = params[:id]

    accounts = Account.find(@id)
    send_sms(accounts.phone, "I'm lost.")

    flash[:notice] = "Successfully sent took meds message to junior" 
    
    redirect_to :controller => "accounts", :action => "show", :id => @id and return
  end
  
  def report_location
    @id = params[:id]

    accounts = Account.find(@id)
    send_sms(accounts.phone, "Back from walk.")
    
    flash[:notice] = "Successfully sent location message to junior" 
    
    redirect_to :controller => "accounts", :action => "show", :id => @id and return
  end 

  def send_sms(phone_number, message) 
    @accounts = Account.all

    @account_sid = 'ACfcbafa8eeedc4d90bb8211e017bf7b74'
    @auth_token = 'xxxxx'# your authtoken here

    formatted_ph_no = phone_number.gsub(/[^0-9]/i, '')
    formatted_ph_no = '1' + formatted_ph_no

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)

    @account = @client.account
    @message = @account.sms.messages.create({:from => '+17788002949', :to => formatted_ph_no, :body => message})
    puts @message
  end 
end
