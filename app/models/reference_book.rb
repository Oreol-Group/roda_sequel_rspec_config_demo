class ReferenceBook < Sequel::Model
  plugin :validation_helpers
  plugin :json_serializer

  def validate
    super
    validates_presence :volume, message: I18n.t(:blank, scope: 'model.errors.reference_book.volume')
  end
end
