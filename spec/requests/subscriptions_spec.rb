require 'rails_helper'

RSpec.describe 'Subscriptions', type: :request do
  context 'Happy Path' do
    describe 'GET api/v1/subscriptions' do
      before :each do
        @customer = Customer.create!(first_name: 'Sid', last_name: 'Vicious', email: 'sid@email.com',
                                     address: '111 Vicious St.')
        @tea = Tea.create!(title: 'Green Tea', description: 'Soothing and delicious', temperature: 200, brewtime: 5,
                           price: 2.00)
        @subscription = Subscription.create!(customer_id: @customer.id, tea_id: @tea.id, title: @tea.title,
                        total_price: @tea.price, frequency: 'weekly', status: 'active')
      end
      it 'can retrieve all of a customers subscriptions' do
        
        get api_v1_subscriptions_path('customer_id' => @customer.id)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        results = JSON.parse(response.body, symbolize_names: true)
        subs = results[:data]

        expect(subs).to be_a Array
        expect(subs[0][:id].to_i).to be_an Integer
        expect(subs[0][:type]).to eq('subscription')
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
      it 'can create a new subscription' do
        subscription_params = {
          "customer_id": @customer.id,
          "tea_id": @tea.id,
          "frequency": 'monthly'
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }

        post api_v1_subscriptions_path, headers: headers, params: JSON.generate(subscription_params)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        results = JSON.parse(response.body, symbolize_names: true)
        subs = results[:data]

        expect(subs).to be_a Hash
        expect(subs[:id].to_i).to be_an Integer
        expect(subs[:type]).to eq('subscription')
        expect(subs[:attributes]).to be_a Hash
        expect(subs[:attributes][:tea_id]).to be_a Integer
        expect(subs[:attributes][:title]).to be_a String
        expect(subs[:attributes][:title]).to eq('Green Tea')
        expect(subs[:attributes][:frequency]).to be_a String
        expect(subs[:attributes][:frequency]).to eq('monthly')
        expect(subs[:attributes][:status]).to be_a String
        expect(subs[:attributes][:status]).to eq('active')
        expect(subs[:attributes][:total_price]).to be_a Float
        expect(subs[:attributes][:total_price]).to eq(8.0)
      end
      it 'can update a subscriptions status to cancelled' do
        subscription_params = {
          "subscription_id": @subscription.id
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }

        put api_v1_subscriptions_path, headers: headers, params: JSON.generate(subscription_params)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        results = JSON.parse(response.body, symbolize_names: true)
        subs = results[:data]

        expect(subs).to be_a Hash
        expect(subs[:attributes][:status]).to eq('cancelled')
      end
    end
  end
  context 'Sad Path' do
    it 'creating a subscription returns error if customer is not found' do
      get api_v1_subscriptions_path('customer_id' => 10)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      results = JSON.parse(response.body, symbolize_names: true)

      expect(results[:error]).to eq('Customer not found')
    end
  end
end
