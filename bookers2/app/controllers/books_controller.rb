class BooksController < ApplicationController
  def new
    @book = Book.new
    @user = User.find(params[:id])
  end

  def create
    flash[:notice] = "create_successfully"
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    if @book.save
      redirect_to book_path(@book.id)
    else
       @books = Book.all
       @user = current_user
      render :index
    end
  end
  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new

  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user

  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    flash[:notice] = "update_successfully"
    @book = Book.find(params[:id])
    @book.update(book_params)
     if @book.save
      redirect_to book_path(@book)
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
    params.require(:book).permit(:title, :body,:user_id)
  end
end
