# sets up base inheritence for models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
