module UserName
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true, uniqueness: true, length: { maximum: 32 }, slug_format: true
  end
end
