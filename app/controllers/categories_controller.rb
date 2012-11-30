class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @advertisements = @category.advertisements.order("created_at DESC")
  end
end
