class AdvertisementsController < ApplicationController
  def index
    @advertisements = Advertisement.all
    @categories = Category.all

    respond_to do |format|
      format.html
    end
  end

  def new
    @advertisement = Advertisement.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @advertisement = Advertisement.new(params[:advertisement])

    respond_to do |format|
      if @advertisement.save
        format.html { redirect_to advertisements_url, notice: "Advertisement has been successfully created" }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
    @advertisement = Advertisement.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def update
    @advertisement = Advertisement.find(params[:id])

    respond_to do |format|
      if @advertisement.update_attributes(params[:advertisement])
        format.html { redirect_to advertisements_url, notice: "Advertisement has been successfully updated" }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def destroy
    @advertisement = Advertisement.find(params[:id])
    @advertisement.destroy

    respond_to do |format|
      format.html { redirect_to advertisements_url }
    end     
  end

end
