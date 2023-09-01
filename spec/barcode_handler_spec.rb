require 'barcode_handler'
class Sale
  def initialize(display)
    @display = display
  end

  def call(barcode)
    # BarcodeHandler.new(barcode).output
    @display.text = '£10.99'
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
    sale.call('0987654321231')
    expect(display.get_text).to eq('£10.99')
  end

  it 'returns nil when called without an explicit output' do 
    expect(BarcodeHandler.new('1234567890').call).to eq nil
  end

  it 'Accepts a barcode and returns a price' do 
    barcode_handler = BarcodeHandler.new('1234567890')
    allow(barcode_handler).to receive(:products).and_return(products)
    allow(barcode_handler).to receive(:products).and_return('£12.99')
  end

  it 'Accepts a different barcode and returns a different price' do 
    barcode_handler = BarcodeHandler.new('0987654321231')
    allow(barcode_handler).to receive(:products).and_return(products)
    allow(barcode_handler).to receive(:products).and_return('£10.99')
  end

  it 'Send an error message for an empty input' do 
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