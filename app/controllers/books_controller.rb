class BooksController < ApplicationController
  def show
  	@book = Book.find(params[:id])
    @user = @book.user #3行目のBook情報からiⅮ取得
    @booknew = Book.new #空のインスタンス。3行目で定義済みだからbooknewへ
    @book_comments = @book.book_comments #commentはNのためAllにしなくてももってこれる。
    @book_commentnew = BookComment.new
  end

  def create
  	@book = Book.new(book_params)#５行目でNewにしているからここもnewにする必要はない
    @book.user_id = current_user.id #ログインしているアカウント情報のＩＤを代入している。コントローラー内でのやりとりであれば、この分だけで十分。念のためカラムへ追加。
    @books = Book.all #renderはviewへ直接行くことしかできないため、コントローラーにあるdata allを見ることはできない。そのためここでこの記載が必要。
    if @book.save
    flash[:notice] = "You have creatad book successfully."
    redirect_to book_path(@book.id)
    else
    render "index"
    end
  end

  def edit
  	@book = Book.find(params[:id])
    if current_user.id != @book.user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "You have creatad book successfully."
    redirect_to book_path(@book.id)
    else
    render "edit"
    end
  end

  def index
    @booknew = Book.new
    @books = Book.all
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end

end


