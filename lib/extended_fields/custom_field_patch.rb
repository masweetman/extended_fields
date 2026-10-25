# frozen_string_literal: true

module ExtendedFields
  module CustomFieldPatch
    def self.prepended(base)
      base.safe_attributes 'hint'
    end
  end
end
