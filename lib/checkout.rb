# frozen_string_literal: true

class Checkout
  attr_reader :products, :basket, :order

  def initialize(discount_rules:, products:)
    @products = products
    @basket = Basket.new(discount_rules, products: products)
    @order = Hash.new(0)
  end

  def scan(item_name)
    return "#{item_name} is not a valid item name" unless item_in_products?(item_name)

    @order[item_name] += 1
  end

  def total
    cost_in_pounds
  end

  private

  def cost_in_pounds
    order_cost.format
  end

  def order_cost
    basket.total(order)
  end

  def item_in_products?(item_name)
    products.map(&:name).include?(item_name)
  end
end
