class VisitUrl
  include Interactor

  def call
    context.url = Url.find_by!(short_url: context.short_url)
    context.url.perform_click(context.browser.name, context.browser.platform.name)
  rescue StandardError
    context.fail!(error: 'Failed to visit the url')
  end
end
