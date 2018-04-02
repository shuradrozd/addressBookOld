require "./phone_number"
require "./address"

class Contact
  attr_writer :first_name, :middle_name, :last_name
  attr_reader :phone_numbers, :addresses

  def initialize
    @phone_numbers = []
    @addresses = []
  end

  def first_name
    @first_name
  end

  def middle_name
    @middle_name
  end

  def last_name
    @last_name
  end

  def add_phone_number(kind, number)
     phone_number = PhoneNumber.new
     phone_number.kind = kind
     phone_number.number = number
     @phone_numbers.push(phone_number)
  end

  def add_address(kind, street_1, street_2, city, state, postal_code)
    address = Address.new
    address.kind = kind
    address.street_1 = street_1
    address.street_2 = street_2
    address.city = city
    address.state = state
    address.postal_code = postal_code
    @addresses.push(address)
  end

  def full_name
    full_name = first_name
    full_name += " #{middle_name}" if !middle_name.nil?
    full_name += " #{last_name}"
    full_name
  end

  def print_phone_numbers
    puts "Phone Numbers:"
      @phone_numbers.each do |phone_number|
        puts phone_number.to_s
      end
  end

  def print_addresses
    puts "Address:"
    @addresses.each do |address|
      puts address.to_s
    end
  end

  def to_s(format = "full name")
    case format
      when "full name"
        full_name
    end
  end

end