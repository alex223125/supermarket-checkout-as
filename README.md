## How to run rubocop

```
rubocop

Inspecting 13 files
.............

13 files inspected, no offenses detected

```


## How to run tests

```
rspec

Finished in 0.01219 seconds (files took 0.31635 seconds to load)
12 examples, 0 failures

```

## How to run app

```
1) open irb in folder with app

2) put in terminal:

require_relative 'config/initialize'

item_one = Item.new(name: 'A', price: 5000)
item_two = Item.new(name: 'B', price: 3000)
item_three = Item.new(name: 'C', price: 2000)
products = [item_one, item_two, item_three]
 
ten_percent_discount = PercentDiscount.new(percent: 10, amount: 20000)
discount_for_item_one = ItemQuantityDiscount.new(item_name: "A", quantity: 2, discount: 1000)
discount_for_item_two = ItemQuantityDiscount.new(item_name: "B", quantity: 3, discount: 1500)
pricing_rules = [discount_for_item_one, discount_for_item_two, ten_percent_discount]
 
checkout = Checkout.new(discount_rules: pricing_rules, products: products)

#Test case 1
checkout.scan("A")
checkout.scan("B")
checkout.scan("C")
price = checkout.total


#Test case 2
checkout.scan("B")
checkout.scan("A")
checkout.scan("B")
checkout.scan("B")
checkout.scan("A")
price = checkout.total


#Test case 3
checkout.scan("C")
checkout.scan("B")
checkout.scan("A")
checkout.scan("A")
checkout.scan("C")
checkout.scan("B")
checkout.scan("C")
price = checkout.total


```


## Supermarket checkout

A supermarket sells the following items:

| Item | Price |
| --- | --- |
| A | £50 |
| B | £30 |
| C | £20 |

In addition, the supermarket offers some discounts:

- 2 items A for £90
- 3 items B for £75
- 10% off total basket cost for baskets worth over £200 (after previous discounts)

You must write a solution using Ruby which is used like this:

```ruby
checkout = Checkout.new(pricing_rules)
checkout.scan(item)
checkout.scan(item)
price = checkout.total
```

Here are some examples:

| Items | Basket total |
| --- | --- |
| A, B, C | £100 |
|  B, A, B, B, A | £165 |
| C, B, A, A, C, B, C | £189 |

When designing your solution keep in mind that a supermarket might want to add new discounts in the future.  What programming principle(s) should you follow to make the process of adding new discounts as straightforward as possible?  Say a new developer takes over from where you left off, and the supermarket needs to make some changes to the system, what (in terms of code design) would best set this new developer up to succeed?  Your design should reflect how you would answer these sorts of questions.

Write tests to make sure your code works. Commit often so we can follow the decisions you made.  Unless you have a very good reason to incorporate rails, a db, or provide a cli, please focus on a PORO solution.

## Submitting your solution

Please create a new branch and create a pull request into master. If you have any questions please email radu@zeneducate.com
