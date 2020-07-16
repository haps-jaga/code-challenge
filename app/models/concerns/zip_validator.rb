class ZipValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "must be a valid 5 digit US postal code") unless validate_with_zipcodes value
  end

  def validate_with_zipcodes(value)
    return ZipCodes.identify(value.to_s).present?
  end
end
