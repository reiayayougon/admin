class Select2Input < SimpleForm::Inputs::CollectionInput
  def input(_wrapper_options)
    @builder.select(attribute_name, collection, input_options, input_html_options)
  end

  def input_html_options
    classes = super[:class] || []
    classes << :'form-control'
    classes << :'js-select2'
    super.merge(class: classes.uniq)
  end
end
