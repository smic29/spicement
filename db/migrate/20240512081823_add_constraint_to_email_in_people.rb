class AddConstraintToEmailInPeople < ActiveRecord::Migration[7.1]
  def change
    change_column :people, :email, :string, null: false
    add_index :people, :email, unique: true
  end
end
