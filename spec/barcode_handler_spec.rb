require 'barcode_handler'

RSpec.describe BarcodeHandler do 

  it 'Accepts a barcode and returns a price' do 
    expect(BarcodeHandler.new('123456789').output).to eq '£12.99'
  end

  it 'Accepts a different barcode and returns a different price' do 
    expect(BarcodeHandler.new('098765432').output).to eq '£10.99'
    expect(BarcodeHandler.new('098765433').output).to eq '£9.99'
  end

  it 'Send an error message for an empty input' do 
    expect(BarcodeHandler.new("").output).to eq 'ERROR: Invalid input'
  end
end