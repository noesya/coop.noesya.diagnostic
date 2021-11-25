class AdminController < ApplicationController
  def index
    @diags = Diag.all.order(created_at: :desc).page(params[:page]).per(50)
  end
end
