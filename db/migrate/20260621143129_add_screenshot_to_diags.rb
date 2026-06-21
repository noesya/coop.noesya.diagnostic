class AddScreenshotToDiags < ActiveRecord::Migration[8.1]
  def change
    add_column :diags, :screenshot, :text
  end
end
