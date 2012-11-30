class AdvertisementsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :new, :create]
  before_filter :authorize, except: [:index, :new, :create]

  def index
    @advertisements = Advertisement.order('created_at DESC')
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

  private

  def authorize
    unless user_signed_in? && current_user.admin?
      redirect_to advertisements_url, alert: "Unauthorized access"      
    end
  end
end
