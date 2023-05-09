class CreateWebsites < ActiveRecord::Migration[6.1]
  def change
    create_table :websites, id: :uuid do |t|
      t.string :url

      t.timestamps
    end
  end
end
