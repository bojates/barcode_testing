require 'barcode'

class BarcodeHandler
  attr_accessor :barcode

  def initialize(barcode = "")
    @barcode = barcode
  end

  def call 
    nil
  end

  def output
    begin
      Barcode::verify_format(barcode)
    rescue ArgumentError => e
      return 'ERROR: ' + e.message
    end
    
    get_price(barcode)
  end
  
  private
  
  def get_price(barcode) 
    price = products[barcode]

    if price.nil? 
      'ERROR: Invalid barcode' 
    # TODO: check this is handling our cases correctly. 
    # But wait for us to agree a data format for our products first.
    elsif price.delete('£').to_f < 0 
      'ERROR: Invalid price'
    else      
      price
    end
  end

  def products
    {}
  end

end
