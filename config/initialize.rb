# frozen_string_literal: true

require 'money'
Money.use_i18n = false

require './lib/checkout'
require './lib/item'
require './lib/basket'

require './lib/discounts/item_quantity_discount'
require './lib/discounts/percent_discount'
