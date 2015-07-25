require_dependency 'custom_field_value'

module ExtendedCustomFieldValuePatch

    def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
            unloadable

            alias_method_chain :value,     :extended
            alias_method_chain :editable?, :extended
        end
    end

    module InstanceMethods

        def value_with_extended
            value = value_without_extended
            if custom_field.multiple? && value.present?
                value.select{ |item| item.present? }
            else
                value
            end
        end

        def editable_with_extended?
            if !customized || customized.new_record?
                custom_field.significant? && editable_without_extended?
            else
                editable_without_extended?
            end
        end

        def ==(x)
            to_s == x.to_s
        end

    end

end
