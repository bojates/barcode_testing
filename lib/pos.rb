class Sale
  def initialize(display)
    @display = display
  end

  def call(barcode = '')
    begin
      Barcode::verify_format(barcode)
    rescue ArgumentError => e
      @display.text = 'ERROR: ' + e.message
      return
    end
    
    @display.text = get_price(barcode)
    nil
  end

  private
  def get_price(barcode)
    price = products[barcode]

    if price.nil? 
      'ERROR: Barcode not found.' 
    elsif price.delete('£').to_f < 0 
      'ERROR: Invalid price.'
    else      
      price
    end
  end

  def products
    {}
  end
end

class Display
  attr_accessor :text

  def get_text
    text
  end
end