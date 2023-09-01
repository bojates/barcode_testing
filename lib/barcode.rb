module Barcode
  def self.verify_format(barcode)
    return true if barcode.size == 10 || barcode.size == 13
    raise ArgumentError, "Invalid input"
  end
end