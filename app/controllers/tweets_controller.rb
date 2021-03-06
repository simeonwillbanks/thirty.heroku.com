class TweetsController < ApplicationController
  
  # GET /tweets
  def index
    @tweets = Tweet.find(:all, :order => "created_at DESC")
    
    respond_to do |format|
      format.html
    end
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new

    respond_to do |format|
      format.html
    end
  end

  # POST /tweets
  def create
    @tweet = Tweet.new(params[:tweet])
    @tweet.user_id = session[:user_id]
    begin
      respond_to do |format|
        if @tweet.save
          flash[:notice] = 'Tweet was successfully created.'
          format.html { redirect_to( :controller => 'tweets', :action => 'index' ) }
        else
          format.html { render :action => "new" }
        end
      end  
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to :controller => 'tweets', :action => 'index'
    end
  end
  
  # DELETE /tweets/1
  def destroy
    @tweet = Tweet.find(params[:id])

    if session[:user_id] != @tweet.user_id or session[:user_is_admin] == false
      flash[:notice] = "Only a tweets owner can delete it!"
      redirect_to :controller => 'tweets', :action => 'index'
    end    
    
    begin
      flash[:notice] = "Tweet has been destroyed."
      @tweet.destroy
    # Want to rescue StandardError, no Exception
    rescue Exception => e
      flash[:notice] = e.message
    end

    respond_to do |format|
      format.html { redirect_to :controller => 'tweets', :action => 'index' }
    end
  end
  
end
