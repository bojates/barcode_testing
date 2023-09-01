require 'barcode_handler'
class Sale
  def initialize(display)
    @display = display
  end

  def call(barcode)
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
      'ERROR: Invalid barcode' 
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

class Display
  attr_accessor :text

  def get_text
    text
  end
end

RSpec.describe BarcodeHandler do 
  # Stub products here so we're not hard coding them in the class
  products = { '1234567890' => '£12.99', 
               '0987654321231' => '£10.99',
               '0987654333213' => '£9.99',
               '9999999999' => '-£4'}

  it 'has a Sale class and a Display class' do
    display = Display.new
    sale = Sale.new(display)
    expect(sale).to receive(:products).and_return(products)

    sale.call('0987654321231')
    expect(display.get_text).to eq('£10.99')
  end

  it 'returns nil to the caller' do 
    display = Display.new
    sale = Sale.new(display)
    
    expect(sale.call('1234567890')).to eq nil
  end

  it 'Accepts a barcode and returns a price' do 
    display = Display.new
    sale = Sale.new(display)
    expect(sale).to receive(:products).and_return(products)
    
    sale.call('1234567890')
    expect(display.get_text).to eq '£12.99'
  end

  it 'Accepts a different barcode and returns a different price' do 
    display = Display.new
    sale = Sale.new(display)
    allow(sale).to receive(:products).and_return(products)

    sale.call('0987654321231')
    expect(display.get_text).to eq '£10.99'
  end

  it 'Send an error message for an empty input' do 
    display = Display.new
    sale = Sale.new(display)
    allow(sale).to receive(:products).and_return(products)

    sale.call('')
    expect(display.get_text).to eq 'ERROR: Invalid input'

    expect(BarcodeHandler.new("").output).to eq 'ERROR: Invalid input'
  end

  it 'Send an error message for an empty input' do 
    expect(BarcodeHandler.new().output).to eq 'ERROR: Invalid input'
  end

  it 'Sends an error message for a string without numbers' do 
    expect(BarcodeHandler.new("Hello").output).to eq 'ERROR: Invalid input'
  end

  it 'Sends an invalid barcode error if the input is correct format but barcode not found' do 
    expect(BarcodeHandler.new('1' * 13).output).to eq 'ERROR: Invalid barcode'
  end
  
  it 'Does not return negative prices' do 
    barcode_handler = BarcodeHandler.new('9999999999')
    allow(barcode_handler).to receive(:products).and_return(products)
    expect(barcode_handler.output).to eq 'ERROR: Invalid price'
  end
end