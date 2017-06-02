class Cart
  attr_accessor :contents

  def initialize(contents)
    @contents = contents || {}
  end

  def total_count
    contents.values.sum
  end
<<<<<<< HEAD
  
=======

>>>>>>> Cart methods for adding item to cart
  def add_item(id)
    contents[id.to_s] = (contents[id.to_s] || 0) + 1
  end

  def items
    Item.where('id = (?)',contents.keys)
  end
<<<<<<< HEAD

  def total_price
    binding.pry
    items.contents
  end
=======
>>>>>>> Cart methods for adding item to cart
end
