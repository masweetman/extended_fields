# frozen_string_literal: true

require File.expand_path('../test_helper', __dir__)

class ExtendedFieldsHintFunctionalTest < Redmine::ControllerTest
  tests CustomFieldsController

  fixtures :users, :email_addresses, :custom_fields, :roles

  setup { @request.session[:user_id] = 1 }

  test 'admin can save a hint and see it in the form' do
    field = IssueCustomField.create!(name: 'Hinted', field_format: 'string', is_for_all: true)

    put :update, params: { id: field.id, custom_field: { hint: 'Enter the code' } }
    assert_response :redirect
    assert_equal 'Enter the code', field.reload.hint

    get :edit, params: { id: field.id }
    assert_response :success
    assert_select 'input#custom_field_hint[value=?]', 'Enter the code'
  end
end

class ExtendedFieldsHintIssuesTest < Redmine::ControllerTest
  tests IssuesController

  fixtures :users, :email_addresses, :projects, :roles, :members, :member_roles, :enabled_modules, :trackers,
           :projects_trackers, :issue_statuses, :enumerations, :workflows, :issues, :custom_fields,
           :custom_fields_projects, :custom_fields_trackers, :custom_values

  test 'hint is shown on the new issue form' do
    @request.session[:user_id] = 1
    field = IssueCustomField.create!(name: 'Hinted', field_format: 'string', is_for_all: true, trackers: Tracker.all,
                                     hint: 'Enter the code')
    get :new, params: { project_id: 1 }
    assert_response :success
    assert_select "p:has(#issue_custom_field_values_#{field.id}) em.custom-field-hint", text: 'Enter the code'
  end
end
