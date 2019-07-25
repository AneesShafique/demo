class AddStatusToCart < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :status, :boolean, default: false
  end
end
