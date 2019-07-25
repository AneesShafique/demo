class Product < ApplicationRecord
  before_destroy :not_referenced_by_any_line_item
  belongs_to :user
  has_many :reviews
  has_many :line_items
  has_many_attached :images
  validates :title, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates_associated :reviews, :line_items

  private

  def not_referenced_by_any_line_item
    return if line_items.empty?

    errors.add(:base, 'Line Items Present')
    throw :abort
  end

  public

  def serial_number
    'PLN-%.6d' % id
  end
end
