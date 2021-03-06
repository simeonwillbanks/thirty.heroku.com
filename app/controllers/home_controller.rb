class HomeController < ApplicationController
  def login
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        session[:user_is_admin] = user.is_admin
        session[:user_name] = user.name
        redirect_to(:action => "index")
      else 
        flash.now[:notice] = "Invalid/user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
    session[:user_is_admin] = nil
    session[:user_name] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end

  def index
  end

end
