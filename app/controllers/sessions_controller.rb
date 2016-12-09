class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    username, password = session_params.values
    @user = User.find_by_credentials(username, password)

    if @user
      login_user!(@user)
      redirect_to subs_url
    else
      flash[:errors] = ["Invalid username or password"]
      redirect_to new_sessions_url
    end
  end

  def destroy
    logout!
    redirect_to new_sessions_url
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end
