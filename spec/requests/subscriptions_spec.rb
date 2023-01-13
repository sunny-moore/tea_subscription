require 'rails_helper'

RSpec.describe "Subscriptions", type: :request do
  context 'Happy Path' do
    describe "GET api/v1/subscriptions" do
      it 'can retrieve all of a customers subscriptions' do
        customer = Customer.create!(first_name: 'Sid', last_name: 'Vicious', email: 'sid@email.com', address: '111 Vicious St.')
        tea = Tea.create!(title: 'Green Tea', description: 'Soothing and delicious', temperature: 200, brewtime: 5, price: 2.00)
        subscription = Subscription.create!(customer_id: customer.id, tea_id: tea.id, title: tea.title, total_price: tea.price, frequency: 'weekly', status: 'active')
        get api_v1_subscriptions_path('customer_id' => customer.id)
        
        expect(response).to be_successful
        expect(response.status).to eq(200)

        results = JSON.parse(response.body, symbolize_names: true)
        subs = results[:data]
      
        expect(subs).to be_a Array
        expect(subs[0][:id].to_i).to be_an Integer
        expect(subs[0][:type]).to eq("subscription")
        expect(subs[0][:attributes]).to be_a Hash
        expect(subs[0][:attributes][:tea_id]).to be_a Integer
        expect(subs[0][:attributes][:title]).to be_a String
        expect(subs[0][:attributes][:title]).to eq('Green Tea')
        expect(subs[0][:attributes][:frequency]).to be_a String
        expect(subs[0][:attributes][:frequency]).to eq('weekly')
        expect(subs[0][:attributes][:status]).to be_a String
        expect(subs[0][:attributes][:status]).to eq('active')
        expect(subs[0][:attributes][:total_price]).to be_a Float
        expect(subs[0][:attributes][:total_price]).to eq(2.0)
      end
    end
  end
  context 'Sad Path' do
    it 'returns error if customer is not found' do
      get api_v1_subscriptions_path('customer_id' => 10)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
    end
  end
  
end
