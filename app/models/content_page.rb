# == Schema Information
#
# Table name: content_pages
#
#  id           :bigint           not null, primary key
#  author       :string
#  content_list :string
#  description  :string
#  intro        :string
#  is_published :boolean          default(FALSE)
#  markdown     :string
#  position     :integer
#  slug         :string
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  next_id      :integer
#  parent_id    :integer
#  previous_id  :integer
#
# Indexes
#
#  index_content_pages_on_position_and_parent_id  (position,parent_id) UNIQUE
#  index_content_pages_on_title                   (title) UNIQUE
#
class ContentPage < ApplicationRecord
  acts_as_tree

  scope :top_level, -> { where(parent_id: nil) }
  scope :order_by_position, -> { order('position ASC') }
  scope :published, -> { where('is_published = true') }

  CHARS_TO_OMIT_FROM_SLUG = ',:()'.freeze
  ONLY_ALPHA_NUMERIC_COMMA_HYPHEN_SPACE_AND_ROUND_BRACES = /\A[a-zA-Z0-9,:\-() ]+\Z/
  TITLE_FORMAT_ERROR_MESSAGE = "Heading should only contain alphabetic, numeric and -#{CHARS_TO_OMIT_FROM_SLUG}".freeze
  validates :title,
            format: { with: ONLY_ALPHA_NUMERIC_COMMA_HYPHEN_SPACE_AND_ROUND_BRACES, message: TITLE_FORMAT_ERROR_MESSAGE }
  validates :title, presence: true, uniqueness: true
  validates :markdown, presence: true
  validates :description, length: { maximum: 254 }

  validates :position, presence: true, numericality: { only_integer: true }, uniqueness: { scope: :parent_id }

  before_save :set_slug_from_title

  after_create do
    ContentPage.reorder
  end

  after_save do
    if saved_change_to_position? || saved_change_to_is_published?
      ContentPage.reorder
    end
  end

  def full_path
    if parent
      "/#{parent.slug}/#{slug}"
    else
      "/#{slug}"
    end
  end

  def set_slug_from_title
    self.slug = title.downcase.tr(' ', '-')
    CHARS_TO_OMIT_FROM_SLUG.each_char do |character|
      self.slug = slug.gsub(character, '')
    end
  end

  def next_page
    ContentPage.find(next_id) if next_id
  end

  def previous_page
    ContentPage.find(previous_id) if previous_id
  end

  # Called when a page is created or a position attribute changes
  class << self
    def reorder
      page_order = []

      ContentPage.published.top_level.order_by_position.each do |p|
        page_order << p
        p.children.published.order_by_position.each do |child|
          page_order << child
        end
      end

      page_order.each_with_index do |page, index|
        page.next_id = page_order[index + 1].id unless page == page_order.last
        page.previous_id = page_order[index - 1].id unless page == page_order.first
        page.save!
      end
    end
  end
end
