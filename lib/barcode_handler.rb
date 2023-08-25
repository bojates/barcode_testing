class BarcodeHandler
  attr_accessor :barcode

  def initialize(barcode)
    @barcode = barcode
  end

  def output
    if barcode == '123456789'
      '£12.99'
    else
      '£10.99'
    end
  end

end