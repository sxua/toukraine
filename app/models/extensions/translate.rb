module Extensions
  module Translate
    extend ActiveSupport::Concern

    module ClassMethods
      def translates *columns
        columns.each do |column|
          LOCALES.keys.each do |locale|
            attr_accessible :"#{column}_#{locale}"
          end

          define_method(column) do
            if self.column_for_attribute("#{column}_#{I18n.locale}")
              self.send("#{column}_#{I18n.locale}")
            else
              self.send("#{column}_#{I18n.default_locale}")
            end
          end
        end
      end
    end
  
  end
end