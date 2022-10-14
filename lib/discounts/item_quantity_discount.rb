# frozen_string_literal: true

class ItemQuantityDiscount
  attr_reader :item_name, :quantity, :discount

  def initialize(item_name:, quantity:, discount:)
    @item_name = item_name
    @quantity = quantity
    @discount = Money.from_cents(discount, 'GBP')
  end

  def run(args = {})
    if appliable?(args[:order])
      calculate_discount(args[:order])
    else
      Money.from_cents(0, 'GBP')
    end
  end

  private

  def calculate_discount(order)
    items_amount = items_amount(order)
    discount_quantity = discount_quantity(items_amount)
    discount_amount(discount_quantity)
  end

  def appliable?(order)
    return false unless items_amount(order)

    items_amount(order) >= quantity
  end

  def items_amount(order)
    @items_amount ||= order[item_name]
  end

  def discount_amount(quantity)
    quantity * discount
  end

  def discount_quantity(items_amount)
    (items_amount / quantity).to_i
  end
end
