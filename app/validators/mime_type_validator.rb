class MimeTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value&.content_type&.in? options[:in]
      record.errors[attribute] << (options[:message] || 'wrong mime type')
    end
  end
end
