require 'rails_helper'

RSpec.describe 'Content Pages' do
  let(:child_page) { create(:content_page, :published, title: 'My child page', parent_id: parent_page.id) }
  let(:parent_page) { create(:content_page, :published, :top_level, title: 'My parent page') }

  it 'hope page renders the title of the service' do
    visit '/'
    expect(page).to have_content('Help for early years providers')
  end

  it 'Navigate to a top level page' do
    visit "/#{parent_page.slug}"
    expect(page).to have_content('My parent page')
  end

  it 'Navigate to a child page' do
    visit "/#{parent_page.slug}/#{child_page.slug}"
    expect(page).to have_content('My child page')
  end

  it 'Navigate to accessibility statement' do
    visit '/accessibility-statement'
    expect(page).to have_content('Accessibility statement for the Help for early years providers service')
  end

  it 'Navigate to contact us' do
    visit '/contact-us'
    expect(page).to have_content('Contact us')
  end

  it 'Navigate to disclaimer' do
    visit '/disclaimer'
    expect(page).to have_content('Linking from help for early years providers')
  end
end
