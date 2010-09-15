class UsersController < ApplicationController
  
  before_filter :authorize_admin, :except => [:index, :show, :edit]
  
  # GET /users
  def index
    @users = User.find(:all, :order => :name)

    respond_to do |format|
      format.html
    end
  end

  # GET /users/new
  def new
    @user = User.new

    respond_to do |format|
      format.html
    end
  end

  # GET /users/1/edit
  def edit
    if session[:user_is_admin]
      id = params[:id]
    else 
      id = session[:user_id]
    end 
    @user = User.find(id)
  end

  # POST /users
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = "User was successfully created."
        format.html { redirect_to :controller => 'users', :action => 'index' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "User was successfully updated."
        format.html { redirect_to :controller => 'users', :action => 'index' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      flash[:notice] = "User was successfully destroyed."
      format.html { redirect_to :controller => 'users', :action => 'index' }
    end
  end
  
  protected
    def authorize_admin
      unless session[:user_is_admin]
        flash[:notice] = "Only an admin can do that!"
        redirect_to :controller => 'users', :action => 'index'
      end
    end
end
