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

  def items
    Item.where('id in (?)',contents.keys)
  end

  def total_price
    items[0].price * total_count
  end
end
