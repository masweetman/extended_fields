require_dependency 'application_helper'

module ExtendedApplicationHelperPatch

    def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
            unloadable

            alias_method_chain :simple_format_without_paragraph, :extended
        end
    end

    module InstanceMethods

        def simple_format_without_paragraph_with_extended(text)
            if controller_name == 'issues'
                text
            else
                simple_format_without_paragraph_without_extended(text)
            end
        end

    end

end
