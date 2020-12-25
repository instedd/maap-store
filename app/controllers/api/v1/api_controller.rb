module Api
  module V1
    class ApiController < ::ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Pagination

      before_action :authenticate_user!

      rescue_from ActionController::ParameterMissing, with: :parameter_missing

      private

      def parameter_missing(error)
        render json: { error: error }, status: :bad_request
      end

      def filter(collection)
        original_scope = collection.order(updated_at: :asc)
        if params[:updated_at_gth].present?
          s = original_scope.where(
            'date_trunc(\'milliseconds\', updated_at) > ?',
            params[:updated_at_gth].to_datetime
          )
        end
        if params[:id_gth].present?
          s = (s || original_scope)
              .or(original_scope.where('id > ?', params[:id_gth]))
        end
        s || original_scope
      end
    end
  end
end
