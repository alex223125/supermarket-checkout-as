# frozen_string_literal: true

class Item
  attr_reader :name, :price

  def initialize(name:, price:)
    @name = name
    @price = Money.from_cents(price, 'GBP')
  end
end
