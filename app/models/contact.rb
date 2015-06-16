class Contact < ActiveRecord::Base
  validates :firstname, presence: true
  validates :lastname,  presence: true
  validates :email,     presence: true, uniqueness: true

  has_many :phones
  accepts_nested_attributes_for :phones
  validates :phones, length: { is: 3 }

  belongs_to :user

  scope :by_letter, -> (letter) { where('lastname LIKE ?', "#{letter}%").order(:lastname) }

  def full_name
    "#{firstname} #{lastname}"
  end

end
