# sets up base inheritence for helpers
module ApplicationHelper

  def full_name(nameable)
    "#{nameable.first_name} #{nameable.last_name}"
  end

  def item_image(imageable, size, options)
    if imageable.photo.present?
      image_tag imageable.photo.url(size), options
    else
      image_tag "#{size}/coffee-beans-shot.png", options
    end
  end
end
