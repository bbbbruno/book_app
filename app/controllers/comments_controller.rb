# frozen_string_literal: true

class CommentsController < ApplicationController
  prepend_before_action :set_commentable, only: %i[create edit update destroy]
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = @commentable.comments.build(comments_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.js { flash.now[:success] = t('flash.new') }
      end
    else
      @commentable.comments.destroy(@comment)
      respond_to do |format|
        format.js { flash.now[:danger] = @comment.errors.full_messages[0] }
      end
    end

    render :index
  end

  def edit
  end

  def update
    if @comment.update(comments_params)
      respond_to do |format|
        format.js { flash.now[:success] = t('flash.update') }
      end
      render :index
    else
      respond_to do |format|
        format.js { flash.now[:danger] = @comment.errors.full_messages[0] }
      end
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.js { flash.now[:success] = t('flash.destroy') }
      end
    end

    render :index
  end

  private
    def set_comment
      @comment = @commentable.comments.find(params[:id])
    end

    def comments_params
      params.require(:comment).permit(:content)
    end
end
