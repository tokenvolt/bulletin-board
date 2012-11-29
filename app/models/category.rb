class Category < ActiveRecord::Base
  attr_accessible :title

  has_many :advertisements

  validates :title, presence: true, uniqueness: true
end
