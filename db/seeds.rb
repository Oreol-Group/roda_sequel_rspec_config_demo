# frozen_string_literal: true

DB[:reference_books].insert(
  volume: 'references',
  content: Sequel.pg_json_wrap([
    { "name": 'Schema modification methods',
      "link": 'https://sequel.jeremyevans.net/rdoc/files/doc/schema_modification_rdoc.html' },
    { "name": 'Migrations',
      "link": 'https://github.com/jeremyevans/sequel/blob/master/doc/migration.rdoc' },
    { "name": 'Using JSON in Postgres with Ruby and Sequel',
      "link": 'https://medium.com/@barryf/using-json-in-postgres-with-ruby-and-sequel-897304158374' }
  ]),
  created_at: Time.now,
  updated_at: Time.now
)
DB[:reference_books].insert(
  volume: 'indexes',
  content: Sequel.pg_json_wrap([
    { "name": 'Documentation',
      "link": 'https://sequel.jeremyevans.net' },
    { "name": 'Repository',
      "link": 'https://github.com/jeremyevans' },
    { "name": 'Publishing', "link": 'https://medium.com/@barryf' }
  ]),
  created_at: Time.now,
  updated_at: Time.now
)
