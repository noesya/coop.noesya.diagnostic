class AdminController < ApplicationController
  def index
    @diags = Diag.all
  end
end
