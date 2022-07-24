class Order < ApplicationRecord
  serialize :commands

  after_initialize do |order|
    order.commands= [] if order.commands == nil
  end
end
