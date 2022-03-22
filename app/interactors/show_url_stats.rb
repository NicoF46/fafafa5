class ShowUrlStats
  include Interactor

  def call
    context.url = Url.find_by!(short_url: context.short_url)
    context.stats = context.url.statistics
  rescue StandardError
    context.fail!(error: 'Failed to visit the url')
  end
end
