class ApplicationController < ActionController::Base
  default_form_builder(GOVUKDesignSystemFormBuilder::FormBuilder)
  include BasicAuth

  before_action { cookies.delete :track_google_analytics }
  before_action do |_controller|
    @page = ContentPage.new(
      title: t(
        params[:action],
        default: params[:action].humanize,
        scope: params[:controller].parameterize,
      ),
    )
  end

private

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end
