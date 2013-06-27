module Datamappify
  module Data
    module Provider
      module ActiveRecord
        extend CommonProvider

        class << self
          # @param source_class_name (see CommonProvider::ModuleMethods#find_or_build_record_class)
          #
          # @return [ActiveRecord::Base]
          def build_record_class(source_class_name)
            class_eval <<-CODE, __FILE__, __LINE__ + 1
              module Datamappify::Data::Record::ActiveRecord
                class #{source_class_name} < ::ActiveRecord::Base
                  self.table_name = '#{source_class_name.pluralize.gsub('::', '_').underscore}'
                end
              end
            CODE

            Datamappify::Data::Record::ActiveRecord.const_get(source_class_name)
          end

          # @return [void]
          def build_record_association(attribute, default_source_class)
            default_source_class.class_eval <<-CODE, __FILE__, __LINE__ + 1
              has_one :#{attribute.source_key}
            CODE

            attribute.source_class.class_eval <<-CODE, __FILE__, __LINE__ + 1
              belongs_to :#{default_source_class.model_name.element}
            CODE
          end

          # @return [void]
          def build_record_reversed_association(attribute, default_source_class)
            default_source_class.class_eval <<-CODE, __FILE__, __LINE__ + 1
              belongs_to :#{attribute.source_key}
            CODE
          end
        end
      end
    end
  end
end
