class Property < ApplicationRecord
    belongs_to :property_type
    belongs_to :property_owner
    has_many :property_reservations, dependent: :destroy

    validates :title, :description, :rooms,
              :bathrooms, :daily_rate, :property_type_id,
              presence: true
    # validates :pets, presence: true
    # validates :parking_slot, presence: true
    
end
