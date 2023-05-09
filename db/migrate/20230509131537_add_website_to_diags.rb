class AddWebsiteToDiags < ActiveRecord::Migration[6.1]
  def change
    add_reference :diags, :website, null: false, foreign_key: true, type: :uuid
  end
end
