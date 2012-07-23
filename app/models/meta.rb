class Meta < ActiveRecord::Base
  include Extensions::Translate
  belongs_to :relative
  attr_accessible :relative_type
  translates :description, :keywords
end
