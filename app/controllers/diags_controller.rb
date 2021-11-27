class DiagsController < ApplicationController
  def index
    @diag = Diag.new
  end

  def show
    @diag = Diag.find params[:id]
    @diag.analyze
    unless params.has_key? :quiet
      @diag.mark_as_viewed
      # SlackNotification.push "Lecture de #{@diag} (#{request.url}?quiet=true)"
    end
  end

  def new
    @diag = Diag.new
  end

  def create
    url = Diag.fix params[:diag][:url]
    @diag = Diag.where(url: url).first_or_create
    if @diag.save
      redirect_to @diag
    else
      render :index, status: :unprocessable_entity
    end
  end
end
