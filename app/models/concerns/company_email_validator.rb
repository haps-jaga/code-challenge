class CompanyEmailValidator < ActiveModel::EachValidator
  REGEX_PATTERN = /\A[A-Z0-9._+-]+@getmainstreet.com\z/i

  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "must be a valid email address. Example: abc@getmainstreet.com") unless value =~ REGEX_PATTERN
  end
end
