module Barcode
  def self.is_valid?(barcode)
    barcode.size == 10 || barcode.size == 13
  end
end