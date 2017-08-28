class Album < ApplicationRecord
  belongs_to :band
  
  validates :name, :year, :band_id, presence: true
  validates :name, uniqueness: { scope: :band_id }
  validates :band_id, numericality: { minimum: 1900, maximum: 3000 }
  validates :live, inclusion: { in: [true, false] }

  after_initialize :set_defaults

  def set_defaults
    self.live ||= false
  end
end
