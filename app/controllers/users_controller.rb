class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end
  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'successfully updated'
    else 
      render :edit
    end
  end
  private

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
  def user_params
    params.require(:user).permit(:name, :introduction ,:profile_image)
  end

end
