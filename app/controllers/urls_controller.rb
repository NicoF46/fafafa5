# frozen_string_literal: true

class UrlsController < ApplicationController
  def index
    @url = Url.new
    @urls = Url.latest
  end

  def create
    result = CreateUrl.call(url_create_params)
    if result.failure?
      flash[:notice] = result.url.present? ? result.url.errors.full_messages : result.error
    else
      flash[:notice] = 'URL shorten created succesfully'
    end
    redirect_to urls_path
  end

  def show
    result = ShowUrlStats.call(short_url: params[:url])
    if result.failure?
      flash[:notice] = result.error
      redirect_to urls_path and return
    end

    render_not_found and return if result.url.nil?

    @url = result.url
    @daily_clicks = result.stats[:daily_clicks]
    @browsers_clicks = result.stats[:browsers_clicks]
    @platform_clicks = result.stats[:platform_clicks]
  end

  def visit
    result = VisitUrl.call(short_url: params[:short_url], browser: browser)

    render_not_found and return if result.failure?
    redirect_to result.url.original_url
  end

  private

  def url_create_params
    params.require(:url).permit(:original_url)
  end
end
