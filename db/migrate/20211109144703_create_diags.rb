class CreateDiags < ActiveRecord::Migration[6.1]
  def change
    create_table :diags, id: :uuid do |t|
      t.string :url
      t.jsonb :websitecarbon
      t.jsonb :lighthouse
      t.integer :views

      t.timestamps
    end
  end
end
