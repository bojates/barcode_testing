require 'barcode_handler'

RSpec.describe BarcodeHandler do 

    it 'Accepts a barcode and returns a price' do 
        expect('£12.99').to eq BarcodeHandler.new('123456789').output
    end

    
end