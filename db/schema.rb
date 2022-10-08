# frozen_string_literal: true

# Version: 20221002182219
Sequel.migration do
  change do
    create_table(:reference_books) do
      primary_key :id, type: :Bignum
      column :volume, 'character varying', null: false
      column :content, 'jsonb'
      column :created_at, 'timestamp with time zone', null: false
      column :updated_at, 'timestamp with time zone', null: false

      index [:content], name: :reference_books_gin
      index [:volume]
    end

    create_table(:schema_migrations) do
      column :filename, 'text', null: false

      primary_key [:filename]
    end
  end
end
