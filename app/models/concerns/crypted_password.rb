module CryptedPassword
  extend ActiveSupport::Concern

  included do
    validates :password,
              length: { minimum: 8 },
              confirmation: true,
              if: :new_record_or_changes_password

    validates :password_confirmation,
              presence: true,
              if: :new_record_or_changes_password
  end

  protected

  def new_record_or_changes_password
    new_record? || changes[:crypted_password]
  end
end
