class CreateUrl
  include Interactor

  def call
    context.url = Url.create!(original_url: context.original_url, short_url: 'temp')
  rescue StandardError
    context.fail!(error: 'Failed to create the URL.')
  end
end
