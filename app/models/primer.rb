class Primer < ActiveRecord::Base
  validates :code, uniqueness: true, presence: true
  validates :name, presence: true
  validates :sequence, presence: true

  # Finds primers that match a specified code, name, AND sequence.
  # Used for quick-searching.
  def self.search(code: "", name: "", sequence: "")
    query = "code LIKE ? AND name LIKE ? AND sequence LIKE ?"
    qparams = ["%#{code}%", "%#{name}%", "%#{sequence}%"]
    return Primer.where(query, *qparams).order(:code)
  end
end
