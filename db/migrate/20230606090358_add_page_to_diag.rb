class AddPageToDiag < ActiveRecord::Migration[6.1]
  def change
    add_reference :diags, :page, foreign_key: true, type: :uuid
    Diag.find_each do |diag|
      page = Page.create url: diag.url
      diag.page = page
      diag.save
    end
    change_column :diags, :page_id, :uuid, null: false
  end
end
