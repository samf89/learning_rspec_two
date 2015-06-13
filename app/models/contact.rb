class Contact < ActiveRecord::Base
  validates :firstname, presence: true
  validates :lastname,  presence: true
  validates :email,     presence: true, uniqueness: true

  scope :by_letter, -> (letter) { where('lastname LIKE ?', "#{letter}%").order(:lastname) }

  def full_name
    "#{firstname} #{lastname}"
  end

end
