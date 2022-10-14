# frozen_string_literal: true

describe Checkout do
  subject(:checkout) { described_class.new(discount_rules: discount_rules, products: products) }

  let(:basket) { instance_double Basket }
  let(:item) { instance_double Item, name: 'A', price: Money.from_cents(5000, 'GBP') }
  let(:products) { [item] }
  let(:percent_discount) { instance_double PercentDiscount, run: Money.from_cents(0, 'GBP') }
  let(:discount_rules) { [percent_discount] }

  describe '#scan' do
    context 'when scanned item exists in products list' do
      it 'adds item to order' do
        checkout.scan('A')
        result = checkout.order
        expected_result = { 'A' => 1 }
        expect(result).to eq(expected_result)
      end
    end

    context 'when scanned item doesnt exists in products list' do
      it 'returns message that item name is not valid' do
        result = checkout.scan('B')
        expected_result = 'B is not a valid item name'
        expect(result).to eq(expected_result)
      end
    end
  end

  describe '#total' do
    context 'when we have correct params' do
      before do
        checkout.scan('A')
        checkout.scan('A')
        checkout.scan('A')
      end

      it 'calculates total in pounds' do
        result = checkout.total
        expected_result = '£150.00'
        expect(result).to eq(expected_result)
      end
    end

    context 'when we have incorrect params' do
      before do
        checkout.scan('CCC')
        checkout.scan('CCC')
        checkout.scan('CCC')
      end

      it 'retruns £0' do
        result = checkout.total
        expected_result = '£0.00'
        expect(result).to eq(expected_result)
      end
    end
  end
end
