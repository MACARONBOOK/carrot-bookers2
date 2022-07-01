class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    respond_to do |format|
      if comment.save
        format.html { redirect_to request.referer, flash.now[:notice] = 'コメントを投稿しました' }
        format.js { render 'book_comments/create'}
      end
    end
  end

  def destroy
    refroute = Rails.application.routes.recognize_path(request.referrer)
    @book = Book.find(refroute[:id])
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    respond_to do |format|
      if book_comment.destroy
        format.html { redirect_to request.referer, flash.now[:alert] = '投稿を削除しました' }
        format.js { render 'book_comments/destroy'}
      end
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
