require 'barcode_handler'

RSpec.describe BarcodeHandler do 

  it 'Accepts a barcode and returns a price' do 
    expect(BarcodeHandler.new('1234567890').output).to eq '£12.99'
  end

  it 'Accepts a different barcode and returns a different price' do 
    expect(BarcodeHandler.new('098765432123').output).to eq '£10.99'
    expect(BarcodeHandler.new('098765433321').output).to eq '£9.99'
  end

  it 'Send an error message for an empty input' do 
    expect(BarcodeHandler.new("").output).to eq 'ERROR: Invalid input'
  end

  it 'Sends an error message for a string without numbers' do 
    expect(BarcodeHandler.new("Hello").output).to eq 'ERROR: Invalid input'
  end

  it 'Sends an invalid barcode error if the input is correct format but not found' do 
    expect(BarcodeHandler.new('1' * 13).output).to eq 'ERROR: Invalid barcode'
  end
end