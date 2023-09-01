require 'barcode'
require 'pos'

RSpec.describe "POS" do 
  let(:display) { Display.new }
  let(:sale) { Sale.new(display) } 
  let(:error_invalid_barcode) { 'ERROR: Invalid input. Please enter a 10 or 13 digit barcode.' }
  let(:error_barcode_not_found) { 'ERROR: Barcode not found.' }

  before(:each) do
    allow(sale).to receive(:products).and_return({ '1234567890' => '£12.99', 
                                                  '0987654321231' => '£10.99',
                                                  '0987654333213' => '£9.99',
                                                  '9999999999' => '-£4'})
  end

  context 'happy path' do
    it 'returns nil to the caller' do 
      expect(sale.call('1234567890')).to eq nil
    end

    it 'accepts a 10 digit barcode and returns a price' do 
      sale.call('1234567890')
      expect(display.get_text).to eq '£12.99'
    end

    it 'accepts a different barcode (13 digits) and returns a different price' do 
      sale.call('0987654321231')
      expect(display.get_text).to eq '£10.99'
    end
  end

  context 'barcode not found' do
    it 'sends an error message if given a barcode it does not have a price for' do
      sale.call('1' * 13)
      expect(display.get_text).to eq error_barcode_not_found
    end
  end

  context 'barcode format is invalid' do
    it 'sends an error message for an empty string' do 
      sale.call('')
      expect(display.get_text).to eq error_invalid_barcode
    end
    
    it 'sends an error message for an empty input' do 
      sale.call()
      expect(display.get_text).to eq error_invalid_barcode
    end

    it 'sends an error message for a mixed string' do 
      sale.call('123456789a')
      expect(display.get_text).to eq error_invalid_barcode
    end

    it 'Sends an error message for a string without numbers' do 
      sale.call('Hello')
      expect(display.get_text).to eq error_invalid_barcode
    end
  end
  
  context 'the barcode format is ok and it is found, but the price is not ok' do
    it 'Does not return negative prices' do 
      sale.call('9999999999')
      expect(display.get_text).to eq 'ERROR: Invalid price.'
    end
  end
end