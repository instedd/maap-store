module Pagination
  def render_paginated(collection, *_args)
    paginated_collection = collection.page(page).per(per_page)
    # greather_updated_at is just sent for legacy purposes.
    # It's necessary for Collectors previous to 1.2.0:
    # https://github.com/instedd/maap-collector/commit/04ce1ee301c2d44137ab754711afa6b5edddc19a
    render json: {
      items: serialized_collection(paginated_collection),
      total_pages: paginated_collection.total_pages,
      current_page: page,
      per_page: per_page,
      total_count: paginated_collection.total_count,
      greather_updated_at: collection.maximum('updated_at')
    }
  end

  private

  def serialized_collection(collection)
    ActiveModelSerializers::SerializableResource.new(collection).as_json
  end

  def per_page
    params.fetch(:per_page, 100)
  end

  def page
    params.fetch(:page, 1)
  end
end
