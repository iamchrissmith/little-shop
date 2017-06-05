class Cart
  attr_accessor :contents

  def initialize(contents)
    @contents = contents || {}
  end

  def total_count
    contents.values.sum
  end

  def add_item(opts)
    contents[opts[:id].to_s] = (contents[opts[:id].to_s] || 0) + 1
  end

  def change_quantity(opts)
    contents[opts[:id].to_s] = opts[:quantity]
  end

  def items
    Item.where('id in (?)',contents.keys)
  end

  def items_for_order
    contents.reduce([]) do |items, (id, quantity)|
      quantity.times do
        items << Item.find(id)
      end
      items
    end
  end

  def total_price
    items.reduce(0) do |sum, item|
      sum += contents[item.id.to_s] * item.price
    end
  end

  def remove_item(id)
    contents.delete(id)
  end
end
