class UserSessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:email])
  	user.authenticate(params[:password])
    sessions[:user_id] = user.id
  	redirect_to todo_lists_path
  end
end
