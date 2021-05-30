class BooksController < ApplicationController
  def create
    @user = current_user
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    # @user = @book.user
  end

  def show
    @book = Book.new
    @book_show = Book.find(params[:id])
    @user = @book_show.user
  end

  def edit
    @books = Book.find(params[:id])
    if @books.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @books = Book.find(params[:id])
    if @books.update(book_params)
      flash[:success] = "You have updated book successfully."
      redirect_to book_path(@books.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body ,:user_id)
  end
end
