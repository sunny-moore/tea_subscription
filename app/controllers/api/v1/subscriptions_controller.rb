class Api::V1::SubscriptionsController < ApplicationController
    
  def index
    customer = Customer.find_by(id: params[:customer_id])

    if customer.present?
      subscriptions = customer.subscriptions
      render json: SubscriptionSerializer.new(subscriptions), status: 200
    else
      render json: { error: 'Customer not found' }, status: 404
    end
  end

  def create
    customer = Customer.find_by(id: params[:customer_id])
    tea = Tea.find_by(id: params[:tea_id])
    if customer.present? && tea.present?
      subscription = Subscription.new(subscription_params)
      subscription.total_price = Subscription.calculate_price(params[:frequency], tea.price)
      subscription.title = tea.title

      if subscription.save
        render json: SubscriptionSerializer.new(subscription), status: 200
      else
        render json: { error: 'Subscription could not be created. Frequency is required' }, status: 400
      end
    else
      render json: { error: 'Customer_id, tea_id and frequency are required' }, status: 400
    end
  end

  def update
    subscription = Subscription.find_by(id: params[:subscription_id])

    if subscription.present? && subscription.status == 'active'
      subscription.update(status: 'cancelled')
      render json: SubscriptionSerializer.new(subscription), status: 200
    else
      render json: { error: 'Subscription is already cancelled or is not found' }, status: 400
    end
  end

  private

  def subscription_params
    params.permit(:customer_id, :tea_id, :frequency, :status)
  end
end
