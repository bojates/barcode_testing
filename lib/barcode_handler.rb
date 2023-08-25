require 'barcode'

class BarcodeHandler
  attr_accessor :barcode

  def initialize(barcode)
    @barcode = barcode
  end

  def output
    begin
      Barcode::verify_format(barcode)
    rescue ArgumentError => e
      return 'ERROR: ' + e.message
    end
    
    products.fetch(barcode) { |barcode| 
      'ERROR: Invalid barcode' 
    }
  end
  
  private
  
  def products
    { '1234567890' => '£12.99', 
      '0987654321231' => '£10.99', 
      '0987654333213' => '£9.99' }
  end

end
