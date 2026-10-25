# frozen_string_literal: true

require File.expand_path('../test_helper', __dir__)

class ExtendedFieldsHintTest < ActionView::TestCase
  include CustomFieldsHelper

  fixtures :users, :email_addresses, :projects, :custom_fields, :custom_values

  setup do
    @field = IssueCustomField.create!(name: 'Hinted', field_format: 'string', is_for_all: true, hint: 'Use <b>this</b>')
  end

  test 'hint is a safe attribute of custom fields' do
    field = IssueCustomField.new
    field.safe_attributes = { 'name' => 'X', 'field_format' => 'string', 'hint' => 'Some hint' }
    assert_equal 'Some hint', field.hint
  end

  test 'edit tag shows the escaped hint below the input' do
    html = custom_field_tag('issue', CustomValue.new(custom_field: @field, customized: Issue.new))
    assert_select_in html, 'input[type=text]'
    assert_select_in html, 'em.custom-field-hint', text: 'Use <b>this</b>'
    assert_not_includes html, '<b>this</b>'
  end

  test 'bulk edit tag shows the hint' do
    html = custom_field_tag_for_bulk_edit('issue', @field)
    assert_select_in html, 'em.custom-field-hint', text: 'Use <b>this</b>'
  end

  test 'no hint markup when the hint is blank' do
    @field.update!(hint: '')
    html = custom_field_tag('issue', CustomValue.new(custom_field: @field, customized: Issue.new))
    assert_select_in html, 'em.custom-field-hint', count: 0
  end

  test 'custom field form renders the hint input' do
    form = ActionView::Helpers::FormBuilder.new(:custom_field, @field, self, {})
    html = render(partial: 'custom_fields/extended', locals: { form: form })
    assert_select_in html, 'input#custom_field_hint[value=?]', 'Use <b>this</b>'
  end

  private

  def assert_select_in(html, *args, **opts)
    assert_select Nokogiri::HTML::DocumentFragment.parse(html.to_s), *args, **opts
  end
end
