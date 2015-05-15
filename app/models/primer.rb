class Primer < ActiveRecord::Base
  validates :code, uniqueness: true
end
