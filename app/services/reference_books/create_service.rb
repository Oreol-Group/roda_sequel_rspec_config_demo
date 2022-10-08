# frozen_string_literal: true

module ReferenceBooks
  class CreateService
    prepend BasicService

    # https://dry-rb.org/gems/dry-initializer/3.0/type-constraints/
    option :volume,  proc(&:to_s)
    option :content, {} do
      option :name,         optional: true
      option :link,         optional: true
      option :author,       optional: true
      option :release,      optional: true
      option :series,       optional: true
    end

    attr_reader :content, :volume, :reference_book

    def call
      old_rb = ReferenceBook.first(volume: @volume)
      @reference_book = old_rb || ReferenceBook.new
      arr = @reference_book.content.to_a
      arr << @content.to_h
      @reference_book.content = Sequel.pg_jsonb_wrap(arr)
      @reference_book.volume = @volume

      if @reference_book.valid?
        @reference_book.save_changes
      else
        fail!(@reference_book.errors)
      end
    end
  end
end
