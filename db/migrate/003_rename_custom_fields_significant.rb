class RenameCustomFieldsSignificant < ActiveRecord::Migration

    def self.up
        rename_column :custom_fields, :is_for_new, :significant
    end

    def self.down
        rename_column :custom_fields, :significant, :is_for_new
    end

end
