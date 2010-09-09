class HomeController < ApplicationController
  def login
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        session[:is_admin] = user.is_admin
        redirect_to(:action => "index")
      else 
        flash.now[:notice] = "Invalid/user/password combination"
      end
    end
  end

  def logout
  end

  def index
  end

end
