require 'barcode_handler'

RSpec.describe BarcodeHandler do 

  it 'Accepts a barcode and returns a price' do 
    expect('£12.99').to eq BarcodeHandler.new('123456789').output
  end

  it 'Accepts a different barcode and returns a different price' do 
    expect('£10.99').to eq BarcodeHandler.new('098765432').output
  end
end