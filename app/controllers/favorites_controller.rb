class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])#なぜ＠必要か
    favorite = @book.favorites.new(user_id: current_user.id)
    favorite.save
    redirect_to books_path
  end
  def destroy
  	@book = Book.find(params[:book_id])
    favorite = @book.favorites.find_by(user_id: current_user.id)
    #resourceなので、favoriteのId（パラメータ）がわたってこないため、UserのIdのBookのIdが必要。
    #二つ検索しないとのどのFavoriteか検索できない。
    #,book_id: book.idと追加すれば＠book不要
    favorite.destroy
    redirect_to books_path
  end
end
