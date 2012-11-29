class Advertisement < ActiveRecord::Base
  attr_accessible :address, :city, :description, :email, :image, :title

  validates_presence_of :address, :city, :description, :email, :title
  validates :title, length: { maximum: 50 }
end
