require_relative 'address_book_schema.rb'

class Contacts

  def initialize(params)
    @id             = params['id']
    @first_name     = params['first_name']
    @last_name      = params['last_name']
    @company        = params['company']
    @phone_number   = params['phone_number']
    @email          = params['email']
    @address        = params['address']
    @created_at     = params['created_at']
    @updated_at     = params['updated_at']
  end

  def save
    $db.execute(
      "INSERT INTO contacts
        (first_name, last_name, company, phone_number, email, address, created_at, updated_at)
       VALUES
        (?, ?, ?, ?, ?, ?, DATETIME('now'), DATETIME('now'));
      ", [@first_name, @last_name, @company, @phone_number, @email, @address] )

    @id=$db.last_insert_row_id
  end

  def change_address(new_address)
    $db.execute(
      "UPDATE contacts
       SET address = '#{new_address}'
       WHERE id = '#{@id}';")
  end

  def delete_contact
    $db.execute(
      "DELETE FROM contacts
      WHERE id = '#{@id}';"
      )
  end

end

class Groups

  def initialize(params)
    @id = params['id']
    @group_name = params['group_name']
    @created_at = params['created_at']
    @updated_at = params['updated_at']
  end

  def add_group
    $db.execute(
      "INSERT INTO groups
        (group_name, created_at, updated_at)
       VALUES
        (?, DATETIME('now'), DATETIME('now'));
      ", [@group_name] )

     @id=$db.last_insert_row_id
  end

  def delete_group
    $db.execute(
      "DELETE FROM groups
      WHERE id = '#{@id}';"
      )
  end

end

AddressBookDB.setup
AddressBookDB.seed


# new_guy = Contacts.new('first_name' => 'Michael', 'last_name' => 'Staszak', 'company' => 'Kung Fu', 'phone_number' => '867-5309', 'email' => 'michael@awesome.air', 'address' => '165 W Schiller Chicago Illinois')
# new_guy.save                       # works
# new_guy.change_address('DBC')
# new_guy.delete_contact

new_group = Groups.new('group_name' => 'SNM Women of America and the former Soviet Union')
new_group.add_group
new_group.delete_group