# frozen_string_literal: true

class PercentDiscount
  attr_reader :percent, :amount

  def initialize(percent:, amount:)
    @percent = percent
    @amount = Money.from_cents(amount, 'GBP')
  end

  def run(args = {})
    if appliable?(args[:total_without_discounts])
      calculate_discount(args[:total_without_discounts])
    else
      Money.from_cents(0, 'GBP')
    end
  end

  private

  def appliable?(checkout_total)
    checkout_total >= amount
  end

  def calculate_discount(checkout_total)
    checkout_total * percent / 100
  end
end
