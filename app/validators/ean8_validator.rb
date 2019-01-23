class Ean8Validator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless EAN8.new(value).valid?
      record.errors[attribute] << (options[:message] || 'is not an ean8')
    end
  end
end
