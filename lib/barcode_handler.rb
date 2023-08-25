class BarcodeHandler
  attr_accessor :barcode

  def initialize(barcode)
    @barcode = barcode
  end

  def output
    products = { '123456789' => '£12.99', '098765432' => '£10.99', '098765433' => '£9.99' }
    if barcode == '123456789'
      products.fetch(barcode)
    else
      products.fetch(barcode)
    end
  end

end

########
# Barcode Scanner with output
# Problem
#  - We get a text input in the form of a barcode, with a carriage return
#  - We want to output, elsewhere (not a return), the price associated with the barcode
#  - Return nothing to the input event
#  - Report Errors to the output, but not the input

# Questions
#  - Handle 'listening', or just build the bit that accepts an input
#  - Handle 'output' to LCD, or send a string somewhere? 

# Examples
# '1234567890 Return' => '£12.99'
# '1234567980 Return' => '£11.50'
# '2234567980 Return' => '£10.00'

## Error conditions
# '12 Return' => 'Invalid Barcode'
# 'Return' => 'Invalid Barcode'
# 'Hello Return' => 'Invalid Barcode'
# '123456780 Return' => Can't find barcode => 'Invalid Barcode'
# '123456789 Return' => gets negative price => 'Invalid price in database'

# Data
## Input: String with carriage return
## Output: String, max line length 80, max lines 5
## Internal: Some sort of lookup for the barcode to translate to price. Hash for now? 
## { 'barcode' => 'price', 'barcode2' => 'price2' }
## Store price with or without symbol? As a string? If we store as a number we can do addition later etc. 
## 

# Algorithm
# Class initialized with barcode 
# Error checking
# Output via a handler, so output can vary
# Outputs are strings