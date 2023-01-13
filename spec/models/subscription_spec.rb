require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'Relationships' do
    it { should belong_to :customer }
    it { should belong_to :tea }
  end
  describe 'Validations' do
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:tea_id) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:total_price) }
    it { should validate_presence_of(:frequency) }
    it { should validate_presence_of(:status) }
  end
  describe 'Model Methods' do
    it 'calculates the total_price with a given frequency and tea price' do
      total_price = Subscription.calculate_price('monthly', 2.00)

      expect(total_price).to eq(8.00)
    end
  end
end
