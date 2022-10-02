# frozen_string_literal: true

require "dry/validation"

class ContentParamsContract < Dry::Validation::Contract
  params do
    required(:volume).filled(:string)
  end

  # # https://dry-rb.org/gems/dry-validation/1.8/
  # rule(:volume) do
  #   key.failure( I18n.t(:missing_parameters, scope: 'api.errors') ) if values[:volume] != 'some_string'  #  3- catch
  # end
end
