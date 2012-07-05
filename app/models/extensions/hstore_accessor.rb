module Extensions
  module HstoreAccessor
    extend ActiveSupport::Concern
    
    module ClassMethods
      def hstore_accessor(store, *attributes)
        attributes.each do |attribute|
          attr_accessible :"#{attribute}"

          define_method(attribute) do
            self.send(store).send(:[], "#{attribute}") rescue nil
          end
          # define_method(:"#{attribute}=") do |value|
          #   data = self.send(:"#{store}_#{I18n.locale}")
          #   self.send(:"#{store}_#{I18n.locale}=", data.merge({ "#{attribute}" => value }))
          # end
        end
      end
    end

  end 
end