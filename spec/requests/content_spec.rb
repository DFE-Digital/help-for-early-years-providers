require 'rails_helper'

RSpec.describe 'Contents' do
  let(:a_page) do
    parent = create(:content_page, :published)
    create(:content_page, :published, parent_id: parent.id)
  end

  before do
    cookies[:track_analytics] = 'true'
  end

  describe 'GET /show' do
    it 'renders a page' do
      get a_page.full_path
      expect(response).to be_successful
    end

    it 'includes the content page description in a meta tag' do
      get a_page.full_path
      expect(html_document.at("meta[name='description']")).to be_present
      expect(html_document.at("meta[name='description']")['content']).to eq(a_page.description)
    end

    it 'does not contain a meta description is content page description blank' do
      a_page.update!(description: '')
      get a_page.full_path
      expect(html_document.at("meta[name='description']")).to be_nil
    end

    it 'renders a 404 when the page is not found' do
      get "#{a_page.full_path}rubbish"
      expect(response).to have_http_status :not_found
    end
  end

  describe 'GET /' do
    it 'renders the landing page / hub page' do
      get '/'
      expect(response).to be_successful
    end

    it 'renders the content pages with HTTP headers to allow caching' do
      get '/'
      expect(response.headers['Cache-Control']).to eq('max-age=3600, public')
    end
  end
end
