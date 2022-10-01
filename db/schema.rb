# Version: 20221001031742
Sequel.migration do
  change do
    create_table(:reference_books, :ignore_index_errors=>true) do
      primary_key :id, :type=>:Bignum
      String :volume, :null=>false
      String :content
      DateTime :created_at, :null=>false
      DateTime :updated_at, :null=>false
      
      index [:content], :name=>:reference_books_gin
    end
    
    create_table(:schema_migrations) do
      String :filename, :text=>true, :null=>false
      
      primary_key [:filename]
    end
  end
end
