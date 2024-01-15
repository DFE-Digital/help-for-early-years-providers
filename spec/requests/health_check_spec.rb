require 'rails_helper'

RSpec.describe 'Health Check' do
  describe 'GET /health' do
    before { get rails_health_check_path }

    it 'renders successfully' do
      expect(response).to be_successful
    end
  end
end
