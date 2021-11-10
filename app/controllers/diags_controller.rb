class DiagsController < ApplicationController
  def index
    @diag = Diag.new
  end

  def show
    @diag = Diag.find params[:id]
    @diag.analyze
  end

  def new
    @diag = Diag.new
  end

  def create
    @diag = Diag.where(url: params[:diag][:url]).first_or_create
    if @diag.save
      redirect_to @diag
    else
      render :index, status: :unprocessable_entity
    end
  end
end
