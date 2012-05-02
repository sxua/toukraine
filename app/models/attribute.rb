class Attribute < ActiveRecord::Base
  belongs_to :relative, polymorphic: true
  scope :current, lambda { where(locale: I18n.locale) }
end
