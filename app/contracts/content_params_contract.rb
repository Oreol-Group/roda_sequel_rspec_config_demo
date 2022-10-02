# frozen_string_literal: true

require "dry/validation"

class ContentParamsContract < Dry::Validation::Contract
  params do
    required(:content).hash do
      required(:name).value(:string)
      required(:link).value(:string)
      required(:author).value(:string)
      required(:release).value(:integer)
      required(:series).value(:string)
    end
  end
end
