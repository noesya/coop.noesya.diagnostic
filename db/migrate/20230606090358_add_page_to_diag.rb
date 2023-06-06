class AddPageToDiag < ActiveRecord::Migration[6.1]
  def change
    add_reference :diags, :page, foreign_key: true, type: :uuid
    Diag.all.select(:id, :url).find_each do |diag|
      page = Page.create url: diag.url
      diag.update_column :page_id, page.id
    end
    change_column :diags, :page_id, :uuid, null: false
  end
end
