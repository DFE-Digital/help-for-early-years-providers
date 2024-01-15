require 'rails_helper'

RSpec.describe ContentPage do
  let(:expected_exception_message) do
    /#{ContentPage::TITLE_FORMAT_ERROR_MESSAGE}/o
  end

  let(:preserves_hypens_page) { create(:content_page, :two_hyphens_and_a_space_in_title) }
  let(:colon_in_title_page) { create(:content_page, :colon_in_title) }

  it 'only allows alphanumeric and spaces in the title' do
    attributes_for_page = attributes_for(:content_page, :with_special_chars_in_title)

    page = described_class.new(attributes_for_page)
    expect { page.save! }.to raise_exception(expected_exception_message)
  end

  it 'sets the slug from the title, converting spaces to hyphens' do
    page = create(:content_page)
    expect { page.save! }.not_to raise_error
  end

  it 'sets the slug from the title, removing commas' do
    page = create(:content_page, :comma_in_title)
    expect { page.save! }.not_to raise_error
  end

  it 'sets the slug from the title, removing round braces' do
    page = create(:content_page, :round_braces_in_title)
    expect { page.save! }.not_to raise_error
  end

  it 'sets the slug from the title, removing colons' do
    expect(colon_in_title_page.slug.count(':')).to(be(0))
  end

  it 'sets title correctly with colon' do
    expect(colon_in_title_page.title.count(':')).to(be(1))
  end

  it 'sets the slug from the title, preserving hyphens' do
    expect(preserves_hypens_page.slug.count('-')).to(be(3))
  end

  it 'sets title correctly, preserving hyphens' do
    expect(preserves_hypens_page.title.count('-')).to(be(2))
  end

  it 'Generates the correct full path for a top level ContentPage' do
    parent = create(:content_page, title: 'An Expected Title')
    expect(parent.full_path).to eq('/an-expected-title')
  end

  it 'Generates the correct full path for a child ContentPage' do
    parent = create(:content_page)
    child = create(:content_page, parent_id: parent.id)
    expect(child.full_path).to eq("/#{parent.slug}/#{child.slug}")
  end
end
