module Api
  module V1
    class SitesController < ApiController
      def index
        render_paginated filter(Site.all)
      end

      def create
        site = Site.new(permitted_params)
        if site.save
          render json: site, status: :created
        else
          render json: { errors: site.errors }, status: :unprocessable_entity
        end
      end

      private

      def permitted_params
        params.require(:site).permit(
          :name, :address, :location, :ownership, :has_farmacy,
          :identified_patients, :permanently_identified_patients
        )
      end
    end
  end
end