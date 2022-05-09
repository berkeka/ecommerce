class Tag < ApplicationRecord
  validates :content, presence: true, uniqueness: true 
end
