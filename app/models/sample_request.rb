class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      a = Mail::Address.new(value)
    rescue Mail::Field::ParseError
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end
class SampleRequest < ApplicationRecord
  validates :email_address, presence: true, email: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true

  before_create :maybe_auto_approve

  private
    # DO NOT auto-approve if:
    #   - email address already exists in db
    #   - shipping address already exists in db
    #   - org size is >= 10
    def maybe_auto_approve
      approve = true
      if org_size != nil && org_size >= 10
        approve = false
      elsif SampleRequest.find_by(street_address: street_address, city: city, state: state, postal_code: postal_code)
        approve = false
      elsif SampleRequest.find_by(email_address: email_address) != nil
        approve = false
      end

      if approve
        self.approved_at = Time.now
        self.approved_by = 0 # 0 is the system user
      end
    end
end
