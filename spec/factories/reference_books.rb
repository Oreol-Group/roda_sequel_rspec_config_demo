# frozen_string_literal: true

FactoryBot.define do
  factory :reference_book do
    volume { nil }
    content { nil }

    trait :note_link do
      volume { 'Note' }
      content { [{ name: 'n1', link: 'l1' }] }
    end

    trait :note_author do
      volume { 'Note' }
      content { [{ name: 'n2', author: 'a2' }] }
    end

    trait :book do
      volume { 'Book' }
      content { [{ name: 'n3', link: 'l3', author: 'a3', release: 'r3', series: 's3' }] }
    end
  end
end
