# Solution for Challenge: Address Book DB from Schema. Started 2013-10-02T00:46:22+00:00require 'sqlite3'

system("rm address_book.db") if File.exists?("address_book.db")


$db = SQLite3::Database.new "address_book.db"


module AddressBookDB
  def self.setup
    $db.execute(
      <<-SQL
        CREATE TABLE contacts (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,
          company VARCHAR(64) NOT NULL,
          phone_number VARCHAR(64) NOT NULL,
          email VARCHAR(64) NOT NULL,
          address VARCHAR(64) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );
      SQL
    )

    $db.execute(
      <<-SQL
        CREATE TABLE contact_book (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          contact_id VARCHAR(64) NOT NULL,
          group_id VARCHAR(64) NOT NULL,
          FOREIGN KEY(contact_id) REFERENCES contacts(id),
          FOREIGN KEY(group_id) REFERENCES groups(id)
        );
      SQL
    )

    $db.execute(
      <<-SQL
        CREATE TABLE groups (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          group_name VARCHAR(64) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );
      SQL
    )
  end

  def self.seed

    $db.execute(
      <<-SQL
        INSERT INTO contacts
          ('first_name', 'last_name', 'company', 'phone_number', 'email', 'address', 'created_at', 'updated_at')
        VALUES
          ('Shawn', 'Klein', 'DBC Chicago', '305-867-5309', 'fake@nonexistant.com', '123fake st', DATETIME('now'), DATETIME('now')),
          ('Andrew', 'Guard', 'DBC Chicago', '555-867-5309', 'yolo@gmail.com', '3203 Cleere Ct Greenville NC 27858', DATETIME('now'), DATETIME('now')),
          ('Uku', 'Taht', 'Being Estonian', '555-867-5309', 'danei@gmail.com', 'Estonia', DATETIME('now'), DATETIME('now'))
          ;
      SQL
    )

    $db.execute(
      <<-SQL
        INSERT INTO groups
          ('group_name', 'created_at', 'updated_at')
        VALUES
          ('NAMBLA', DATETIME('now'), DATETIME('now'))
          ;
      SQL
    )
  end
end
