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
    when 'plain'
      slide_url = slide.url
    when 'tour'
      slide_url = slide.tour ? tour_path(tour_type_id: slide.tour.tour_type.try(:slug), id: slide.tour.try(:slug)) : nil
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
  
  def new_child_fields_template(form_builder, association, options={})
    association = :"#{association.to_s.pluralize}"
    object_name = "#{form_builder.object.class.name}_#{association}_attributes_"
    options[:object] ||= form_builder.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= "admin/shared/#{association}_form"
    
    content_for :handlebars do
      render partial: options[:partial], locals: { fb: form_builder, association: association, options: options }
    end
  end

  def add_child_link(association)
    link_to 'Add ' + association.to_s.humanize, '#', class: 'js-form-add button', 'data-association' => association.to_s.pluralize
  end

  def remove_child(name, f)
    f.hidden_field(:_destroy) + tag(:br) + content_tag(:span, 'Remove ') + check_box_tag("remove_#{name}", 1, false, id: nil)
    end

  def currency_code_for(currency)
    CURRENCIES.find { |k, v| v == currency }.try(:first) || :uah
  end

  def price_with_currency(price, currency)
    currency_code = currency_code_for(currency)
    unit = I18n.t("list.currencies.#{currency_code}")
    format = currency_code == :uah ? '%n %u' : '%u%n'
    number_to_currency price, unit: unit, format: format, separator: nil, delimiter: nil, precision: 0
  end

  def lang_images(object, method, langs)
    langs.map { |lang| image_tag("flags/#{lang}.png") if object.send(:"#{method}_#{lang}") }.compact.join(' ').html_safe
  end

  def inverted_dir
    params[:dir] ? params[:dir] == 'desc' ? 'asc' : 'desc' : 'desc'
  end

  def dir_for(column)
    column.to_s == params[:column] ? inverted_dir : params[:dir]
  end

  def sort_params(column)
    { column: column, dir: params[:dir] ? dir_for(column) : 'asc', page: nil }
  end
  
  def sortings_for(controller, action, *columns)
    result = columns.map do |column|
      classes = [column]
      classes += ['selected', inverted_dir] if params[:column] == column.to_s
      content_tag(:div, class: classes.join(' ')) do
        link_to(I18n.t("sortings.#{column}"), url_for(sort_params(column).merge({ controller: controller, action: action })))
      end
    end
    result << content_tag(:div, nil, class: :clear)
    result.join.html_safe
  end

  def page_title
    if defined? @title
      if @title.is_a?(Array)
        (@title << Option.get('site_title')).join(Option.get('title_divider'))
      else
        [@title, Option.get('site_title')].join(Option.get('title_divider'))
      end
    else
      Option.get('site_title')
    end
  end

  def meta_description_tag
    content = (defined? @description) ? @description : Option.get('meta_description')
    tag(:meta, name: 'description', content: truncate(content, length: 155, separator: ' ')).html_safe
  end
end