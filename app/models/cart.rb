class Cart
  attr_accessor :contents

  def initialize(contents)
    @contents = contents || {}
  end

  def total_count
    contents.values.sum
  end

  def add_item(id)
    contents[id.to_s] = (contents[id.to_s] || 0) + 1
  end

  def remove_item(id)
    contents[id.to_s] = (contents[id.to_s] || 0) - 1
  end

  def items
    Item.where('id in (?)',contents.keys)
  end

  def total_price
    items.reduce(0) do |sum, item|
      sum += contents[item.id.to_s] * item.price
    end
  end
end
