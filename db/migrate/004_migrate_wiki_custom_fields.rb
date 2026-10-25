# frozen_string_literal: true

class MigrateWikiCustomFields < ActiveRecord::Migration[4.2]
  def self.up
    return unless column_exists?(:custom_fields, :format_store)

    format_store = { text_formatting: 'full' }.to_yaml
    execute(<<~SQL.squish)
      UPDATE custom_fields
      SET field_format = 'text', format_store = #{connection.quote(format_store)}
      WHERE field_format = 'wiki'
    SQL
  end
end
