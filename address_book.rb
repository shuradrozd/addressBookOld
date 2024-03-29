require "yaml"
require "./contact"

class AddressBook
  attr_reader :contacts

  def initialize
    @contacts = []
    open()
  end

  def run
    loop do
      puts "Address Book"
      puts "a: Add Contact"
      puts "s: Search"
      puts "p: Print Address Book"
      puts "e: Exit"
      print "Enter your choice: "
      input = gets.chomp.downcase
      case input
        when "a"
          add_contact
        when "p"
          print_contact_list
        when "s"
          print "Search term: "
          search = gets.chomp
          find_by_name(search)
          find_by_phone_number(search)
          find_by_address(search)

        when "e"
          save
          break
      end
    end
  end

  def open
     if File.exist?("contacts.yaml")
        @contacts = YAML.load_file("contacts.yaml")
     end
  end

  def save
    File.open("contacts.yaml", "w") do |file|
      file.write(contacts.to_yaml)
    end
  end


  def print_contact_list
    @contacts.each do |contact|
      puts contact.to_s
      puts contact.phone_numbers
      puts contact.addresses

    end
  end

  def find_by_name(name)
    results = []
    search = name.downcase
    @contacts.each do |contact|
      results.push(contact) if contact.full_name.downcase.include?(search)
    end
    print_results("Name search results: #{search}", results)
  end

  def find_by_phone_number(phone_number)
    results = []
    search = phone_number.gsub("-", "")
    @contacts.each do |contact|
      contact.phone_numbers.each do |phone_number|
        results.push(contact) if phone_number.number.gsub("-", "").include?(search)
      end
    end
    print_results("Phone search results: #{search}", results)
  end

  def find_by_address(query)
    results = []
    search = query.downcase
    @contacts.each do |contact|
      contact.addresses.each do |address|
        if address.to_s("long").downcase.include?(search)
          results.push(contact) unless results.include?(search)
        end
      end
    end
    print_results("Address search results:#{search}", results)
  end

  def print_results(search, results)
    puts search
    results.each do |contact|
      puts contact.to_s
      puts contact.print_phone_numbers
      puts contact.print_addresses
      puts "/n"
    end
  end

  def add_contact
    contact = Contact.new
    print "First name: "
    contact.first_name = gets.chomp
    print "Middle name: "
    contact.middle_name = gets.chomp
    print "Last name: "
    contact.last_name = gets.chomp
    @contacts.push(contact)
    loop do
      puts "Add phone number or address?"
      puts "p: Add phone number"
      puts "a: Add Address"
      puts "Any other key to go exit"
      response = gets.chomp.downcase
      case response
        when "p"
          print "Phone number kind (Home, Work, etc.) "
          kind = gets.chomp
          print "Number: "
          number = gets.chomp
          contact.add_phone_number(kind, number)
        when "a"
          print "Address kind (Home, Work, etc.): "
          kind = gets.chomp
          print "Address line 1: "
          street_1 = gets.chomp
          print "Address line 2: "
          street_2 = gets.chomp
          print "City: "
          city = gets.chomp
          print "State: "
          state = gets.chomp
          print "Postal Code: "
          postal_code = gets.chomp
          contact.add_address(kind, street_1, street_2, city, state, postal_code)
        else
          break
      end
      puts "\n"
    end
  end

end

address_book = AddressBook.new
address_book.run