# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cust1 = Customer.create!(first_name: 'Sally', last_name: 'Fields', email: 'sally@email.com', address: '123 First St.')
cust2 = Customer.create!(first_name: 'Robert', last_name: 'Redfield', email: 'robert@email.com', address: '456 Second St.')
cust3 = Customer.create!(first_name: 'Julia', last_name: 'Roberts', email: 'Julia@email.com', address: '789 Third St.')

tea1 = Tea.create!(title: 'Green Tea', description: 'Soothing and delicious', temperature: 200, brewtime: 5, price: 2.00)
tea2 = Tea.create!(title: 'Chamomile Tea', description: 'Relaxing and mild', temperature: 200, brewtime: 5, price: 1.50)
tea3 = Tea.create!(title: 'Lemon Ginger Tea', description: 'Tart and spicy', temperature: 200, brewtime: 5, price: 2.50)

sub1 = Subscription.create!(customer_id: cust1.id, tea_id: tea1.id, title: tea1.title, total_price: tea1.price, frequency: 'weekly', status: 'active')
sub2 = Subscription.create!(customer_id: cust1.id, tea_id: tea2.id, title: tea2.title, total_price: tea2.price * 2, frequency: 'bi_weekly', status: 'active')
sub3 = Subscription.create!(customer_id: cust2.id, tea_id: tea2.id, title: tea2.title, total_price: tea2.price * 4, frequency: 'monthly', status: 'active')
sub4 = Subscription.create!(customer_id: cust2.id, tea_id: tea3.id, title: tea3.title, total_price: tea3.price , frequency: 'weekly', status: 'active')
sub5 = Subscription.create!(customer_id: cust3.id, tea_id: tea3.id, title: tea3.title, total_price: tea3.price * 2, frequency: 'bi_weekly', status: 'active')
sub6 = Subscription.create!(customer_id: cust3.id, tea_id: tea1.id, title: tea1.title, total_price: tea3.price * 4, frequency: 'monthly', status: 'active')