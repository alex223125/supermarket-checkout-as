# frozen_string_literal: true

describe ItemQuantityDiscount do
  subject(:item_quantity_discount) { described_class.new(item_name: 'A', quantity: 2, discount: 1000) }

  describe '#apply' do
    context 'when item quantity discount is appliable' do
      let(:args) { { order: { 'A' => 2 } } }

      it 'calculates discount' do
        result = item_quantity_discount.run(args)
        expected_result = Money.from_cents(1000, 'GBP')
        expect(result).to eq(expected_result)
      end
    end

    context 'when percent discount is not appliable' do
      let(:args) { { order: { 'B' => 2 } } }

      it 'returns zero as discount' do
        result = item_quantity_discount.run(args)
        expected_result = Money.from_cents(0, 'GBP')
        expect(result).to eq(expected_result)
      end
    end
  end
end
