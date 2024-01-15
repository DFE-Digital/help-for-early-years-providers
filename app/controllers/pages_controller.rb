class PagesController < ApplicationController
  after_action :set_cache_headers

  # This is a page whose title and children's titles are rendered
  # a block in the landing_page_layout template
  FEATURED_PAGE_TITLES = ['Get help to improve your practice', 'Safeguarding and welfare'].freeze
  FEATURED_PAGE_HASH = {
    'Get help to improve your practice' => 'Get help',
    'Safeguarding and welfare' => 'Safeguarding',
  }.freeze

  def index
    @featured_pages = ContentPage.published.where(title: FEATURED_PAGE_TITLES).order_by_position
    # Don't show featured pages in the cards
    @content_pages = ContentPage.top_level.published.order_by_position - @featured_pages

    respond_to do |format|
      format.html { render :index, layout: 'landing_page_layout' }
    end
  end

  def show
    @page = ContentPage.find_by!(slug: params['slug'])
    # If in a section page and page has parent, it must be a child of existing page
    not_found if (!@page.is_published || @page.parent || content_section?) && params['section'] != parent_slug

    respond_to do |format|
      format.html { render :show, layout: 'content_page' }
    end
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def accessibility_statement; end

  def disclaimer; end

  def contact_us; end

  def child_development_training; end

private

  def set_cache_headers
    response.headers['Cache-Control'] = 'max-age=3600, public' if cookies[:track_analytics].present?
  end

  def parent_slug
    @page.parent&.slug
  end

  def content_section?
    params['section'].present?
  end
end
