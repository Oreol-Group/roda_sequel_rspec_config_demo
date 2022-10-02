# frozen_string_literal: true

module ReferenceBooks
  class CreateService
    prepend BasicService

    # https://dry-rb.org/gems/dry-initializer/3.0/type-constraints/
    option :volume,  proc(&:to_s)

    attr_reader :content, :volume, :reference_book

    def call
      old_rb = ReferenceBook.first(volume: @volume)
      @reference_book = old_rb || ReferenceBook.new
      @reference_book.content.to_a << @content.to_h
      @reference_book.volume = @volume

      if @reference_book.valid?
        @reference_book.save
      else
        fail!(@reference_book.errors)
      end
    end
  end
end
