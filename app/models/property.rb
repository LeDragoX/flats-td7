class Property < ApplicationRecord
    belongs_to :property_type
    validates :title, :description, :rooms, :bathrooms, :daily_rate, :property_type_id,
              presence: { message: 'não pode ficar em branco' }
    # validates :pets, presence: true
    # validates :parking_slot, presence: true
    
end
