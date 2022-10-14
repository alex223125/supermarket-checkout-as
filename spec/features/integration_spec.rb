# frozen_string_literal: true

describe 'IntegrationSpec' do
  subject(:checkout) { Checkout.new(discount_rules: discount_rules, products: products) }

  let(:item_one) { Item.new(name: 'A', price: 5000) }
  let(:item_two) { Item.new(name: 'B', price: 3000) }
  let(:item_three) { Item.new(name: 'C', price: 2000) }
  let(:products) { [item_one, item_two, item_three] }

  let(:ten_percent_discount) { PercentDiscount.new(percent: 10, amount: 20_000) }
  let(:discount_for_item_one) { ItemQuantityDiscount.new(item_name: 'A', quantity: 2, discount: 1000) }
  let(:discount_for_item_two) { ItemQuantityDiscount.new(item_name: 'B', quantity: 3, discount: 1500) }

  let(:discount_rules) { [discount_for_item_one, discount_for_item_two, ten_percent_discount] }

  context 'when we have task condition one' do
    before do
      checkout.scan('A')
      checkout.scan('B')
      checkout.scan('C')
    end

    it 'does not apply any discounts' do
      result = checkout.total
      expected_result = '£100.00'
      expect(result).to eq(expected_result)
    end
  end

  context 'when we have task condition two' do
    before do
      checkout.scan('B')
      checkout.scan('A')
      checkout.scan('B')
      checkout.scan('B')
      checkout.scan('A')
    end

    it 'applies quantity discounts' do
      result = checkout.total
      expected_result = '£165.00'
      expect(result).to eq(expected_result)
    end
  end

  context 'when we have task condition three' do
    before do
      checkout.scan('C')
      checkout.scan('B')
      checkout.scan('A')
      checkout.scan('A')
      checkout.scan('C')
      checkout.scan('B')
      checkout.scan('C')
    end

    it 'applies quantity and percent discounts' do
      result = checkout.total
      expected_result = '£188.00'
      expect(result).to eq(expected_result)
    end
  end
end
