# frozen_string_literal: true

module ExtendedFields
  module CustomFieldsHelperPatch
    def custom_field_tag(prefix, custom_value)
      with_custom_field_hint(super, custom_value.custom_field)
    end

    def custom_field_tag_for_bulk_edit(prefix, custom_field, objects = nil, value = '')
      with_custom_field_hint(super, custom_field)
    end

    private

    def with_custom_field_hint(field_html, custom_field)
      return field_html if custom_field.hint.blank?

      safe_join([field_html, tag.br, content_tag(:em, custom_field.hint, class: 'custom-field-hint')])
    end
  end
end
