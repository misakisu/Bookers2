class UsersController < ApplicationController
   # before_action :correct_user, only: [:edit, :update]
  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new
    @relationship = Relationship.where(user_id: current_user.id, follow_user_id: params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(@current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
    render "edit"
    end
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end


  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  # def correct_user
  #    @user = User.find(params[:id])
  #      unless current_user?(@user)
  #      redirect_to books_path
  # end
end
