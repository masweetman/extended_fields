module Redmine
    module FieldFormat

        class ProjectFormat < RecordList
            add 'project'
            self.customized_class_names = nil
            self.form_partial = 'custom_fields/formats/project'

            def cast_single_value(custom_field, value, customized = nil)
                unless value.blank?
                    Project.find_by_id(value)
                else
                    nil
                end
            end

            def possible_values_options(custom_field, object = nil)
                if object.is_a?(User)
                    projects = Project.visible(object).all
                else
                    projects = Project.visible.all
                end
                projects.collect{ |project| [ project.name, project.id.to_s ] }
            end
        end

    end
end
