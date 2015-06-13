class Phone < ActiveRecord::Base
  belongs_to :contact

  validates :phone_type, presence: true
  validates :phone_number, presence: true, uniqueness: { scope: [:contact_id] }

end
