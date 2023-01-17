class Lease < ApplicationRecord
  validates :rent, presence: true

  
  belongs_to :tenant
  belongs_to :apartment
end
