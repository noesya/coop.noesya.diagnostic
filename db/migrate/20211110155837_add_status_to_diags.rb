class AddStatusToDiags < ActiveRecord::Migration[6.1]
  def change
    add_column :diags, :status, :integer, default: 0
  end
end
