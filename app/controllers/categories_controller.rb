class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @advertisements = @category.advertisements
  end
end
