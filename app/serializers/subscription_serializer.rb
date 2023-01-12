class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :customer_id, :tea_id, :title, :total_price, :frequency, :status
end
