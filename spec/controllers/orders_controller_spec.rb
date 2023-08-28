require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  before(:each) do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new order' do
        expect {
          post :create, params: {
            order: {
              customer_name: 'John Doe',
              customer_contact: '012 123 1234',
              order_type: 'Dine In',
              order_items_attributes: [
                {
                  quantity: 2,
                  item_id: @item1.id
                }
              ]
            }
          }
        }.to change(Order, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new order with no customer' do
        expect {
            post :create, params: {
            order: {
              customer_name: '',
              order_items_attributes: [
                {
                  quantity: 2,
                  item_id: @item1.id
                }
              ]
            }
          }
        }.not_to change(Order, :count)
      end

      it 'does not create a new order with no line items' do
        expect {
          post :create, params: {
            order: {
              customer_name: 'John Doe',
              customer_contact: '012 123 1234',
              order_type: 'Dine In',
              order_items_attributes: []
            }
          }
        }.not_to change(Order, :count)
      end
    end

    context 'Calculation' do
      it 'item have no discount offered' do
        @item1.update(price: 40, tax_rate: 30)

        expect {
          post :create, params: {
            order: {
              customer_name: 'John Doe',
              customer_contact: '012 123 1234',
              order_type: 'Dine In',
              order_items_attributes: [
                {
                  quantity: 2,
                  item_id: @item1.id
                }
              ]
            }
          }
        }.to change(Order, :count).by(1)

        order = Order.last
        expect(order.price).to be_within(0.001).of(80.0)
        expect(order.discount).to be_within(0.001).of(0.0)
        expect(order.taxable_amount).to be_within(0.001).of(24.0)
        expect(order.payable).to be_within(0.001).of(104.0)
      end

      it 'item have discounts offered' do
        @item1.update(price: 40, tax_rate: 30)
        @item2.update(price: 60, tax_rate: 10)
        @discount1 = FactoryBot.create(:discount, item: @item1, discount_rate: 50, cap_amount: nil)
        @discount2 = FactoryBot.create(:discount, item: @item2, discount_rate: 20, cap_amount: nil)
        @discount3 = FactoryBot.create(:discount, item: @item2, discount_rate: 40, cap_amount: 10)


        expect {
          post :create, params: {
            order: {
              customer_name: 'John Doe',
              customer_contact: '012 123 1234',
              order_type: 'Dine In',
              order_items_attributes: [
                {
                  quantity: 2,
                  item_id: @item1.id
                },
                {
                  quantity: 5,
                  item_id: @item2.id
                }
              ]
            }
          }
        }.to change(Order, :count).by(1)

        order = Order.last
        expect(order.price).to be_within(0.001).of(380.0)
        expect(order.discount).to be_within(0.001).of(100.0)
        expect(order.taxable_amount).to be_within(0.001).of(54.0)
        expect(order.payable).to be_within(0.001).of(334.00)
      end
    end
  end
end
