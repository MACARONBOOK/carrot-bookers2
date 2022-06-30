class FavoritesController < ApplicationController
  before_action :book_params

  def create
    Favorite.create(user_id: current_user.id, book_id: params[:id])

    respond_to do |format|
      if favorite.save
        format.html { redirect_to request.referer}
        format.js { render 'favorites/create'}
      end
    end
  end

  def destroy
    Favorite.find_by(user_id: current_user.id, book_id: params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to request.refere}
      format.js { render 'favorites/destroy'}
    end
  end

  private

  def book_params
    @book = Book.find(params[:id])
  end

end