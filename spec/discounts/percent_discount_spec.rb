# frozen_string_literal: true

describe PercentDiscount do
  subject(:percent_discount) { described_class.new(percent: 10, amount: amount) }

  describe '#run' do
    let(:args) { { total_without_discounts: Money.from_cents(25_000, 'GBP') } }

    context 'when percent discount is appliable' do
      let(:amount) { 20_000 }

      it 'calculates percent discount' do
        result = percent_discount.run(args)
        expected_result = Money.from_cents(2500, 'GBP')
        expect(result).to eq(expected_result)
      end
    end

    context 'when percent discount is not appliable' do
      let(:amount) { 30_000 }

      it 'returns zero as percent discount' do
        result = percent_discount.run(args)
        expected_result = Money.from_cents(0, 'GBP')
        expect(result).to eq(expected_result)
      end
    end
  end
end
