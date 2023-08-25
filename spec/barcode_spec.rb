require 'barcode'

RSpec.describe Barcode do 

  describe 'is_valid?' do 
    it 'returns a result when asked for barcode validity' do 
      expect(Barcode::is_valid?('123')).to_not be_nil
    end

    it 'returns false if a barcode is less than 10 chars' do 
      expect(Barcode::is_valid?('a' * (1..9).to_a.sample)).to be false
    end

    it 'returns false if a barcode is 11 or 12 chars' do 
      expect(Barcode::is_valid?('1' * 11)).to be false
      expect(Barcode::is_valid?('A' * 12)).to be false
    end

    it 'returns false if a barcode is more than 13 chars' do 
      expect(Barcode::is_valid?('1' * 14)).to be false
      expect(Barcode::is_valid?('H' * 200)).to be false
    end

    it 'returns true if a barcode has 10 chars' do 
      expect(Barcode.is_valid?('0123456789')).to be true
    end

    it 'returns true if a barcode has 13 chars' do 
      expect(Barcode.is_valid?('0123456789123')).to be true
    end
  end

  describe 'verify_format' do 
    it 'returns true if passed a 10 digit string' do 
      expect(Barcode::verify_format('0123456789')).to be true
    end
  end
end