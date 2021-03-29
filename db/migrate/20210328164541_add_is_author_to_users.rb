class AddIsAuthorToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_author, :boolean
  end
end
