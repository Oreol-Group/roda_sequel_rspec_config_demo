# https://sequel.jeremyevans.net/rdoc/files/doc/schema_modification_rdoc.html
# https://github.com/jeremyevans/sequel/blob/master/doc/migration.rdoc
# https://medium.com/@barryf/using-json-in-postgres-with-ruby-and-sequel-897304158374
Sequel.migration do
  up do
    create_table(:reference_books) do
      primary_key :id, type: :Bignum
      column :volume, "character varying", null: false
      column :description, "jsonb"
      column :created_at, "timestamp with time zone", null: false
      column :updated_at, "timestamp with time zone", null: false
    end

    run 'CREATE INDEX reference_books_gin ON reference_books USING GIN(description);'
  end

  down do
    alter_table(:reference_books) do
      drop_index :description, name: :reference_books_gin
    end
    drop_table(:reference_books)
  end
end
