# frozen_string_literal: true

require 'dry/validation'

class ContentParamsContract < Dry::Validation::Contract
  params do
    required(:volume)
    optional(:content).hash do
      optional(:name).value(:string)
      optional(:link).value(:string)
      optional(:author).value(:string)
      optional(:release).value(:integer)
      optional(:series).value(:string)
    end
  end

  # https://dry-rb.org/gems/dry-validation/1.8/
  rule(:volume) do
    #  the 1-st Dry::Validation's catch
    key.failure(I18n.t(:missing_parameters, scope: 'api.errors')) if values[:volume].nil?
  end
end
