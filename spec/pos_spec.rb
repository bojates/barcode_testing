require 'barcode'
require 'pos'

RSpec.describe "POS" do 
  let(:display) { Display.new }
  let(:sale) { Sale.new(display) } 

  before(:each) do
    allow(sale).to receive(:products).and_return({ '1234567890' => '£12.99', 
      '0987654321231' => '£10.99',
      '0987654333213' => '£9.99',
      '9999999999' => '-£4'})
  end

  it 'returns nil to the caller' do 
    expect(sale.call('1234567890')).to eq nil
  end

  it 'Accepts a barcode and returns a price' do 
    sale.call('1234567890')
    expect(display.get_text).to eq '£12.99'
  end

  it 'Accepts a different barcode and returns a different price' do 
    sale.call('0987654321231')
    expect(display.get_text).to eq '£10.99'
  end

  it 'Send an error message for an empty input' do 
    sale.call('')
    expect(display.get_text).to eq 'ERROR: Invalid input'
  end

  it 'Sends an invalid barcode error if the input is correct format but barcode not found' do 
    sale.call('1' * 13)
    expect(display.get_text).to eq 'ERROR: Invalid barcode'
  end
  
  it 'Send an error message for an empty input' do 
    sale.call()
    expect(display.get_text).to eq 'ERROR: Invalid input'
  end

  it 'Sends an error message for a string without numbers' do 
    sale.call('Hello')
    expect(display.get_text).to eq 'ERROR: Invalid input'
  end
  
  it 'Does not return negative prices' do 
    sale.call('9999999999')
    expect(display.get_text).to eq 'ERROR: Invalid price'
  end
end