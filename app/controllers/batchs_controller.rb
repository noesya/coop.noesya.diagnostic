class BatchsController < ApplicationController

  def index
  end

  def create
    # warning: double quotes are mandatory here
    text = params[:text]&.gsub("\r", '')
    urls = text.split("\n")
    urls.each do |url|
      url = Diag.fix url
      url = url[0..-2] if url.ends_with? '/'
      @diag = Diag.where(url: url).first_or_create
      @diag.analyze
    end
  end
end
