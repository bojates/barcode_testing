module Barcode
  def self.is_valid?(barcode)
    barcode.size == 10 || barcode.size == 13
  end

  def self.verify_format(barcode)
    if self.is_valid?(barcode)
      true
    else
      raise ArgumentError, "Invalid input"
    end
  end
end