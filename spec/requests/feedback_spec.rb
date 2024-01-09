require 'rails_helper'

RSpec.describe '/feedbacks' do
  let(:valid_attributes) do
    { page_useful: %w[yes no].sample }
  end

  let(:invalid_attributes) do
    { page_useful: 'foo' }
  end
  let(:redirect_url) { contact_us_url }

  describe 'POST /create' do
    context 'with valid parameters' do
      subject(:feedback_post) { post feedbacks_url, params: { feedback: valid_attributes }, headers: { 'HTTP_REFERER' => redirect_url } }

      it 'redirects back to referring page with target feedback' do
        feedback_post
        expect(response).to redirect_to("#{redirect_url}#feedback")
      end

      it 'sets cookie to input' do
        feedback_post
        expect(cookies[:feedback_page_useful]).to eq(valid_attributes[:page_useful])
      end
    end

    context 'with invalid parameters' do
      subject(:feedback_post) { post feedbacks_url, params: { feedback: invalid_attributes }, headers: { 'HTTP_REFERER' => redirect_url } }

      it 'redirects back to referring page with target feedback' do
        feedback_post
        expect(response).to redirect_to("#{redirect_url}#feedback")
      end

      it 'clears cookie' do
        feedback_post
        expect(cookies[:feedback_page_useful]).to be_blank
      end
    end

    context 'without referer' do
      subject(:feedback_post) { post feedbacks_url, params: { feedback: valid_attributes } }

      it 'redirects back to root with target feedback' do
        feedback_post
        expect(response).to redirect_to("#{root_path}#feedback")
      end
    end

    context 'with invalid parameter and cookie set' do
      subject(:feedback_post) { post feedbacks_url, params: { feedback: invalid_attributes }, headers: { 'HTTP_REFERER' => redirect_url } }

      before { cookies[:feedback_page_userful] = 'yes' }

      it 'clears cookie' do
        feedback_post
        expect(cookies[:feedback_page_useful]).to be_blank
      end

      it 'redirects back to referring page with target feedback' do
        feedback_post
        expect(response).to redirect_to("#{redirect_url}#feedback")
      end
    end
  end
end
