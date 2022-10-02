# frozen_string_literal: true

require './app/helpers/pagination_links'
require './app/helpers/validations'
require './app/helpers/api_errors'

class App
  include PaginationLinks
  include Validations
  include ApiErrors

  PAGE_FIRST = 1


  hash_path("/api/v1/reference_books") do |r|
    r.is do
      r.get do
        # https://stackoverflow.com/questions/16937731/sinatra-kaminari-pagination-problems-with-sequel-and-postgres
        page = Integer(r.params[:page]) rescue PAGE_FIRST

        # hhttps://sequel.jeremyevans.net/rdoc/classes/Sequel/Dataset.html
        reference_books = ReferenceBook.reverse_order(:updated_at)
          .paginate(page.to_i, Settings.pagination.page_size )

        {data: reference_books.all, links: pagination_links(reference_books)}
     end

      r.post do
        volume_params = validate_with!(::ContentParamsContract)
        @dry_validation_response = volume_params.errors.to_hash
        # raise Roda::RodaPlugins::TypecastParams::Error if volume_params.is_a?(Dry::Validation::Result)  #  2-nd catch

        result = ReferenceBooks::CreateService.call(
          volume: volume_params[:volume],
          content: params[:content]
        )

        if result.success?
          response.status = 201
          {data: result.reference_book}
        else
          response.status = 422
          error_response(result.reference_book)
        end
      end
    end
  end
end
