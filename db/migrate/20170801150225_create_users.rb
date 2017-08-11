class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.text :hash_password
      t.string :authentication_token
      t.string :uid
      t.string :phone_no
      t.boolean :active

      t.timestamps
    end
  end
end
