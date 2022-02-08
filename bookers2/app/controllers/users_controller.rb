class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end


  end

  def update
    flash[:notice] = "update_successfully"
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end


  private
  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end
end
