# frozen_string_literal: true

describe Basket do
  subject(:basket) { described_class.new(pricing_rules, products: products) }

  let(:item_one) { instance_double Item, name: 'A', price: 5000 }
  let(:item_two) { instance_double Item, name: 'B', price: 3000 }
  let(:products) { [item_one, item_two] }
  let(:percent_discount) { instance_double PercentDiscount, run: 0 }
  let(:pricing_rules) { [percent_discount] }
  let(:order) { { 'A' => 1, 'B' => 1 } }

  describe '#total' do
    context 'when we have pricing rules and products' do
      it 'calculates total' do
        result = basket.total(order)
        expected_result = 8000
        expect(result).to eq(expected_result)
      end
    end
  end
end
