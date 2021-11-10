class AddAttemptsToDiags < ActiveRecord::Migration[6.1]
  def change
    add_column :diags, :attempts, :integer, default: 0
  end
end
