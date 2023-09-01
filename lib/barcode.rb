module Barcode
  def self.verify_format(barcode)
    return true if (barcode =~ /^[0-9]{10}$|[0-9]{13}$/) 
    raise ArgumentError, "Invalid input. Please enter a 10 or 13 digit barcode."
  end
end