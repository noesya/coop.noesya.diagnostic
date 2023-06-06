class AddPageToDiag < ActiveRecord::Migration[6.1]
  def change
    add_reference :diags, :page, foreign_key: true, type: :uuid
    Diag.all.select(:id, :url, :page_id).find_each do |diag|
      url = diag.attributes[:url]
      page = Page.where(url: url).first_or_create
      diag.update_column :page_id, page.id
    end
    change_column :diags, :page_id, :uuid, null: false
  end
end
