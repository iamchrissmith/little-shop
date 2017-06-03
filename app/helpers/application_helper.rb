# sets up base inheritence for helpers
module ApplicationHelper

  def full_name(nameable)
    "#{nameable.first_name} #{nameable.last_name}"
  end
end
