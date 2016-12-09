class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(session_params)

    if @user
      login_user!(@user)
      redirect subs_url
    else
      flash[:errors] = @user.errors_full_message
      render :new
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
