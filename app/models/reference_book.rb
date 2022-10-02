# frozen_string_literal: true

class ReferenceBook < Sequel::Model
  def validate
    super
    validates_presence :volume, message: I18n.t(:blank, scope: 'model.errors.reference_book.volume')
  end
end
