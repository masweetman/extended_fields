# frozen_string_literal: true

Redmine::Plugin.register :extended_fields do
  name 'Extended fields'
  author 'Mike Sweetman'
  author_url 'http://www.andriylesyuk.com'
  description 'Adds a hint, shown below the input, to custom fields.'
  url 'https://github.com/masweetman/extended_fields.git'
  version '2.0.0'
  requires_redmine version_or_higher: '7.0.0'
end

ExtendedFields::Hooks # registers the view listener

CustomField.prepend(ExtendedFields::CustomFieldPatch) unless CustomField < ExtendedFields::CustomFieldPatch
unless CustomFieldsHelper < ExtendedFields::CustomFieldsHelperPatch
  CustomFieldsHelper.prepend(ExtendedFields::CustomFieldsHelperPatch)
end
