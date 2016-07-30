module ApplicationHelper
  def page_title
    if @title
      "#{@title} | #{t('app_name')}"
    else
      t('app_name')
    end
  end

  def present(model, class_override = nil)
    klass = "#{class_override || model.class.name.underscore}_presenter".camelize.constantize
    presenter = klass.new(model)
    yield(presenter) if block_given?
  end

  def present_each(collection, class_override = nil, &block)
    collection.each do |model|
      present(model, class_override, &block)
    end
  end
end
