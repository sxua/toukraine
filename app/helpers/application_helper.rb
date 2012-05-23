# encoding: UTF-8

module ApplicationHelper
  def box(options={})
    title = options.delete(:title)
    options[:class] ||= 'box'
    content = ''
    content << capture { content_tag(:h3, title) } if title
    content << capture { yield }.to_s
    concat content_tag(:div, content.html_safe, options)
  end

  def modal(options={})
    footer ||= options.delete(:footer)
    header ||= options.delete(:header)
    options[:style] = ['display:none;', options[:style]].compact.join(' ')
    options[:class] = ['modal', options[:class]].compact.join(' ')
    content = ''

    content << capture do
      content_tag :div, class: 'modal-header' do
        if header
          header.()
        else
          content_tag(:a, '×', class: 'close', 'data-dismiss' => 'modal') + content_tag(:h3, options[:title] || options[:id].to_s.humanize)
        end
      end
    end

    content << capture do
      content_tag :div, class: 'modal-body' do
        if block_given?
          yield
        end
      end
    end

    if footer
      content << capture do
        if footer.is_a? Proc
          content_tag :div, footer.(), class: 'modal-footer'
        else
          footer
        end
      end
    end

    concat content_tag(:div, content.html_safe, options)
  end
  
  def slide_url_for(slide)
    slide_url = case slide.url_type
    when 'text'
      slide_url = slide.url
    when 'tour'
      slide_url = slide.tour ? url_for(slide.tour) : nil
    when 'hotel'
      slide_url = slide.hotel ? url_for(slide.hotel) : nil
    else
      nil
    end
    slide_url
  end

  def menu_for(section)
    content = ''
    pages = Page.published.for(section)

    if pages.any?
      content << capture do
        link_to('#', class: 'dropdown-toggle', 'data-toggle' => 'dropdown') do
          "#{I18n.t("topbar.for_#{section}")} #{content_tag(:b, nil, class: 'caret')}".html_safe
        end
      end

      content << capture do
        content_tag(:ul, id: "#{section}_menu", class: 'dropdown-menu') do
          pages.map { |page| content_tag(:li, link_to(page.title, url_for(page))) }.join.html_safe
        end
      end
      
      content_tag(:li, content.html_safe, class: 'dropdown')
    end
  end
end