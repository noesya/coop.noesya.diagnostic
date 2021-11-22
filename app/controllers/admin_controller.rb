class AdminController < ApplicationController
  def index
    @diags = Diag.all.order(:url)
  end
end
