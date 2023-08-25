require 'barcode'

RSpec.describe Barcode do 

  describe 'verify_format' do 
    it 'raise an error if a barcode is less than 10 chars' do 
      expect { Barcode::verify_format('a' * (1..9).to_a.sample) }.to raise_error ArgumentError, "Invalid input"
    end

    it 'returns true if passed a 10 digit string' do 
      expect(Barcode::verify_format('0123456789')).to be true
    end
    
    it 'raises error if a barcode is 11 or 12 chars' do 
      expect { Barcode::verify_format('1' * 11) }.to raise_error ArgumentError, "Invalid input"
      expect { Barcode::verify_format('A' * 12) }.to raise_error ArgumentError, "Invalid input"
    end
    
    it 'returns true if a barcode has 13 chars' do 
      expect(Barcode::verify_format('0123456789123')).to be true
    end

    it 'raises an error if passed empty string' do 
      expect { Barcode::verify_format("").output }.to raise_error(ArgumentError, "Invalid input")
    end

    it 'raises an error if a barcode is more than 13 chars' do 
      expect { Barcode::verify_format('H' * 200) }.to raise_error ArgumentError, "Invalid input"
    end

  end
end