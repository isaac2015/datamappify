require 'datamappify/data/provider/common/relational/persistence'
require 'datamappify/data/provider/common/relational/record/mapper'
require 'datamappify/data/provider/common/relational/record/writer'

module Datamappify
  module Data
    module Provider
      module ActiveRecord
        class Persistence < Data::Provider::Common::Relational::Persistence
          def destroy(ids)
            data_class.destroy(ids)
          end

          def exists?(id)
            data_class.exists?(id)
          end

          def transaction(&block)
            data_class.transaction(&block)
          end

          private

          def record_attributes_method
            :attributes
          end
        end
      end
    end
  end
end
