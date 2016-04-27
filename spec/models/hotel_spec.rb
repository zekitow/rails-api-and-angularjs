require 'rails_helper'

RSpec.describe Hotel, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name)              }
    it { should validate_presence_of(:address)           }
    it { should validate_presence_of(:star_rating)       }
    it { should validate_numericality_of(:star_rating)   }
    it { should validate_presence_of(:accomodation_type) }
  end
end