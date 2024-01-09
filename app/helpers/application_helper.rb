module ApplicationHelper
  def path_for_this_page(page)
    # Add parent links
    if page.parent_id
      "/#{page.parent.slug}/#{page.slug}"
    else
      "/#{page.slug}"
    end
  end

  def page_current?(page)
    params[:slug] == page.slug
  end

  # 'Overview' menu items inserted into the mobile menu.  Without
  # this extra check, the Overview menus appear as current when
  # they are not.
  def mobile_menu_section_current?(page)
    params[:slug] == page.slug || params[:section] == page.slug
  end

  def translate_markdown(markdown)
    sanitize(GovspeakDecorator.translate_markdown(markdown))
  end

  def print_button(*additional_classes)
    button = button_to class: 'govuk-link gem-c-print-link__button',
                       onclick: 'window.print()',
                       data: { module: 'print-link' } do
      'Print this page'
    end
    classes = ['gem-c-print-link', 'print-button'] + additional_classes
    content_tag :div, button, class: classes
  end

  def govuk_input_classes(input_type, errors: nil)
    classes = %w[govuk-input]
    classes << "govuk-#{input_type}"
    classes << 'govuk-input--error' if errors.present?
    classes
  end

  def link_to_feedback(args = {})
    link_to(
      'Give Feedback',
      Rails.configuration.feedback_url,
      {
        class: 'govuk-button',
        data: {
          track_category: 'Onsite Feedback',
          track_action: 'GOV-UK Open Form',
        },
        aria: {
          controls: 'something-is-wrong',
          expanded: 'false',
        },
      }.merge(args),
    )
  end
end
