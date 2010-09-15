class TweetsController < ApplicationController
  
  # GET /tweets
  # GET /tweets.xml
  def index
    @tweets = Tweet.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tweets }
    end
  end

  # GET /tweets/1
  # GET /tweets/1.xml
  def show
    @tweet = Tweet.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tweet }
    end
  end

  # GET /tweets/new
  # GET /tweets/new.xml
  def new
    @tweet = Tweet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tweet }
    end
  end

  # POST /tweets
  # POST /tweets.xml
  def create
    @tweet = Tweet.new(params[:tweet])
    @tweet.user_id = session[:user_id]
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to(@tweet, :notice => 'Tweet was successfully created.') }
        format.xml  { render :xml => @tweet, :status => :created, :location => @tweet }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tweet.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @tweet = Tweet.find(params[:id])

    if session[:user_id] != @tweet.user_id or session[:user_is_admin] == false
      flash[:notice] = "Only a tweets owner can delete it!"
      redirect_to :controller => 'tweets', :action => 'index'
    end    
    
    begin
      flash[:notice] = "Tweet has been destroyed."
      @tweet.destroy
    rescue Exception => e
      flash[:notice] = e.message
    end

    respond_to do |format|
      format.html { redirect_to(tweets_url) }
      format.xml  { head :ok }
    end
  end
  
end
