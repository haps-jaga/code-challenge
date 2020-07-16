class Company < ApplicationRecord
  has_rich_text :description
  validates :email, allow_blank: true, uniqueness: true, company_email: true
  validates :zip_code, presence: true, zip: true

  before_save :set_city_and_state, if: Proc.new { |company| company.zip_code_changed? }

  private

  def set_city_and_state
    zip_code = ZipCodes.identify(self.zip_code.to_s)
    if zip_code
      self.city = zip_code[:city]
      self.state = zip_code[:state_code]
    end
  end
end
