module Translate
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def translates *columns
      columns.each do |column|
        class_eval <<-EOV
          def #{column}
            unless self.send("#{column}_#{I18n.locale}")
              self.send("#{column}_#{I18n.locale}")
            else
              #{column}_#{I18n.default_locale}
            end
          end
        EOV
      end
    end
  end
  
end

ActiveRecord::Base.send :include, Translate