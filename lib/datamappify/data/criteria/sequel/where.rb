require 'datamappify/data/criteria/sequel/criteria_method'

module Datamappify
  module Data
    module Criteria
      module Sequel
        class Where < CriteriaMethod
          # @param scope [Sequel::DataSet]
          #
          # @return [Sequel::DataSet]
          def records(scope = nil)
            records_scope(scope).where(structured_criteria)
          end
        end
      end
    end
  end
end
