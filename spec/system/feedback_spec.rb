require 'rails_helper'

RSpec.describe 'Feedback' do
  it 'Page with feedback options' do
    visit '/'

    expect(page).to have_text('Is this page useful?')
  end

  it 'User gives positive feedback' do
    visit '/'

    within '#feedback' do
      page.click_link_or_button('Yes')
    end
    expect(page).to have_no_text('Is this page useful?')
    expect(page).to have_text('Thank you for your feedback')
  end

  it 'User gives negative feedback and closes dialogue' do
    visit '/'

    within '#feedback' do
      page.click_link_or_button('No')
    end
    expect(page).to have_no_text('Is this page useful?')
    expect(page).to have_text('Help us improve Help for early years providers')

    within '#feedback' do
      page.click_link_or_button('Close')
    end

    expect(page).to have_text('Is this page useful?')
  end
end
