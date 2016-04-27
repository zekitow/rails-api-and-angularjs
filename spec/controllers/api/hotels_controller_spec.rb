require 'rails_helper'

describe Api::HotelsController, type: :api do

  context 'GET /api/hotels' do
    subject { get '/api/hotels' }

    context 'when do not have hotels' do
      it { expect(subject.status).to eql(200) }
      it { expect(JSON.parse(subject.body)).to be_empty }
    end

    context 'when have two hotels' do
      before(:each) { FactoryGirl.create_list(:hotel, 2) }

      it { expect(subject.status).to eql(200) }
      it { expect(subject).to match_response_schema('hotels') }
    end

  end

  context 'POST /api/hotels' do
    subject { post '/api/hotels', request }

    context 'without required fields' do
      let(:request) { {} }

      it { expect(subject.status).to eql(422) }
      it { expect(subject).to match_response_schema('missing_required_fields') }
    end

    context 'with required fields' do
      let(:request) { { hotel: { name: 'name', address: 'address', star_rating: '3.5', accomodation_type: 'accomodation_type' } } }

      it { expect(subject.status).to eql(201) }
      it { expect(subject).to match_response_schema('hotel') }
    end

  end

  context 'GET /api/hotels/1' do

    subject { get '/api/hotels/1' }

    context 'when hotel does not exists' do

      it { expect(subject.status).to eql(404) }
      it { expect(subject.body).to be_blank }
    end

    context 'when hotel exists' do
      before(:each) { FactoryGirl.create(:hotel, id: 1) }

      it { expect(subject.status).to eql(200) }
      it { expect(subject).to match_response_schema('hotel') }
    end

  end

  context 'PUT /api/hotels/1' do
    let(:request) { { hotel: { id: 1, name: 'name', address: 'address', star_rating: '3.5', accomodation_type: 'accomodation_type' } } }

    subject { put '/api/hotels/1', request }

    context 'when hotel does not exists' do
      it { expect(subject.status).to eql(404) }
      it { expect(subject.body).to be_blank }
    end

    context 'when hotel exists' do
      before(:each) { FactoryGirl.create(:hotel, id: 1) }

      it { expect(subject.status).to eql(204) }
      it { expect(subject.body).to be_blank }
    end

  end


  context 'Remove and Hotel' do
    subject { delete '/api/hotels/1', request }

    let(:request) { { hotel: { id: 1 } } }

    context 'when hotel does not exists' do
      it { expect(subject.status).to eql(404) }
      it { expect(subject.body).to be_blank }
    end

    context 'when hotel exists' do
      before(:each) { FactoryGirl.create(:hotel, id: 1) }

      it { expect(subject.status).to eql(204) }
      it { expect(subject.body).to be_blank }
    end
  end


  context 'Find Hotels by string' do
    subject { get '/api/search', request }
  
    before(:each) do
      FactoryGirl.create(:hotel, id: 1, name: 'Pitangueiras') 
      FactoryGirl.create(:hotel, id: 2, address: 'R. Rocha Pombo, 160')
    end

    context 'when param are not sent' do
      let(:request) { { } }

      it { expect(subject.status).to eql(422) }
      it { expect(subject.body).to be_blank }
    end
    
    context 'when nothing matches' do
      let(:request) { { q: 'Unmatched text' } }

      it { expect(subject.status).to eql(200) }
      it { expect(JSON.parse(subject.body)).to be_empty }
    end

    context 'when name matches' do
      let(:request) { { q: 'Pitangueiras' } }

      it { expect(subject.status).to eql(200) }
      it { expect(subject).to match_response_schema('hotels') }
      it { expect(JSON.parse(subject.body).size).to eql(1) }
    end

    context 'when address matches' do
      let(:request) { { q: 'Rocha' } }

      it { expect(subject.status).to eql(200) }
      it { expect(subject).to match_response_schema('hotels') }
      it { expect(JSON.parse(subject.body).size).to eql(1) }
    end

    context 'when name and address matches' do
      let(:request) { { q: 'Royal' } }

      before(:each) do
        FactoryGirl.create(:hotel, name:    'Royal Atlântica') 
        FactoryGirl.create(:hotel, address: 'Port Royal')
      end

      it { expect(subject.status).to eql(200) }
      it { expect(subject).to match_response_schema('hotels') }
      it { expect(JSON.parse(subject.body).size).to eql(2) }
    end
  end
end