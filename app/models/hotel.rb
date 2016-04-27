class Hotel < ActiveRecord::Base
  include SearchCop
  search_scope :search do
    attributes :name, :address
  end

  validates :name, :address, :star_rating, :accomodation_type, presence: true
  validates_numericality_of :star_rating
end
