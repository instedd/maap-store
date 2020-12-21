module Pagination
  def render_paginated(collection, *_args)
    paginated_collection = collection.page(page).per(per_page)
    render json: {
      items: serialized_collection(paginated_collection),
      total_pages: paginated_collection.total_pages,
      current_page: page,
      per_page: per_page,
      total_count: paginated_collection.total_count,
      greather_updated_at: paginated_collection.pluck(:updated_at).max
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
