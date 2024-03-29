class DiagsController < ApplicationController
  def index
    @diag = Diag.new
  end

  def show
    @diag = Diag.find params[:id]
    @page = @diag.page
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
    url = url[0..-2] if url.ends_with? '/'
    @page = Page.where(url: url).first_or_create
    @diag = @page.diags.create
    if @diag.save
      redirect_to @diag
    else
      render :index, status: :unprocessable_entity
    end
  end
end
