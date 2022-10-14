# frozen_string_literal: true

class Basket
  attr_reader :product_prices, :discount_rules

  def initialize(discount_rules, products: nil)
    @discount_rules = discount_rules
    @product_prices = products(products)
  end

  def total(order)
    total_without_discounts = total_without_discounts(order)
    total_discount = total_discount(total_without_discounts, order)
    total_without_discounts - total_discount
  end

  private

  def total_without_discounts(order)
    result = 0
    order.each do |product|
      result += total_for(product)
    end
    result
  end

  def total_for(product)
    @product_prices[product[0]] * product[1]
  end

  def total_discount(total_without_discounts, order)
    result = 0
    discount_rules.each do |rule|
      result += single_discount(rule, total_without_discounts, order)
    end
    result
  end

  def single_discount(rule, total_without_discounts, order)
    rule.run({ total_without_discounts: total_without_discounts, order: order })
  end

  def products(products)
    products.map { |product| [product.name, product.price] }.to_h
  end
end
