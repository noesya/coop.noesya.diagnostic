class AdminController < ApplicationController
  def index
    @diags = Diag.all.order(created_at: :desc)
  end
end
