class Barcode < ActiveRecord::Base
  validates :barcode, presence: true, ean8: true

  enum source: %i(excel)
end
