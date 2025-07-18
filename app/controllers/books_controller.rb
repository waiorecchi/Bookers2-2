class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: 'You have created book successfully.'
    else
      @books = Book.all
      @user = current_user      
      render :index
    end
  end
  
  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end
  
  def new
    @book = Book.new
  end
  
  def show
    @book = Book.find(params[:id])
    @user = @book.user 
    @new_book = Book.new
  end
  
  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to books_path, notice: 'successfully delete'
    else
      redirect_to books_path
    end
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'successfully updated'
    else 
      render :edit
    end
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body, :name, :introduction)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end
end