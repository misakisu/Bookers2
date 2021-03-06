class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    #@comment = @book.book_comments.new(user_id: current_user.id)と上２行は同じ。params必要なため上2行で記載。
    #comment.book_idへbook.idを代入する。ネストしているため、親と子という関係。
    #親（本）の情報を定義しないとどの本か分からないため。どのUserがどのBookにコメントしたのかを登録するため。
    if comment.save
      flash[:success] = "Comment was successfully created."
      redirect_to book_path(book)#引数は@不要。bookで定義されているから。
    end
      #book_comments = BookComment.where(book_id: book.id)
      #render '/books/show'
  end
  def destroy #各コメント削除をする場合どのbookcommentを削除するかを指定する。
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.find_by(id: params[:id])
    if @book_comment.user == current_user
    @book_comment.destroy
    #book.id等、ローカル変数を定義していないのにもかかわらず利用できない。
    redirect_to book_path(@book.id)
    end
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
    #book_idは不要な理由：bookのコントローラで生成されているため。ここで生成されているもののみ必要。
  end
end
