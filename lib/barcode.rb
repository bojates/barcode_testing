module Barcode
  def self.verify_format(barcode)
    if barcode.size == 10 || barcode.size == 13
      true
    else
      raise ArgumentError, "Invalid input"
    end
  end
end