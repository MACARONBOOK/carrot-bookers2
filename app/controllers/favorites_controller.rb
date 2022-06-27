class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    Favorite.create(user_id: current_user.id, book_id: params[:id])
    favorite.save
    redirect_to books_path
  end

  def destroy
    book = Book.find(params[:book_id])
    Favorite.find_by(user_id: current_user.id, book_id: params[:id]).destroy
    redirect_to books_path
  end


end