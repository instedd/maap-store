module Api
  module V1
    class ElectronicPharmacyStockRecordsController < ApplicationController
      def create
        electronic_pharmacy_stock_record = build_electronic_pharmacy_stock_record

        if electronic_pharmacy_stock_record.save
          AnonymizeElectronicPharmacyStockRecordWorker.perform_async(
            electronic_pharmacy_stock_record.id
          )
          render json: electronic_pharmacy_stock_record, status: :created
        else
          render json: electronic_pharmacy_stock_record.errors, status: :unprocessable_entity
        end
      end

      private

      def build_electronic_pharmacy_stock_record
        electronic_pharmacy_stock_record = ElectronicPharmacyStockRecord.new(permitted_params)
        electronic_pharmacy_stock_record.obfuscation_state = :pending
        electronic_pharmacy_stock_record
      end

      def permitted_params # rubocop:disable Metrics/AbcSize
        params.permit(
          :name, :header_row, :data_rows_from, :data_rows_to, :sheet_file, :site_id,
          :file_name
        ).tap do |whitelisted|
          whitelisted[:rows] = params[:rows] if params[:rows]
          whitelisted[:columns] = params[:columns] if params[:columns]
          whitelisted[:phi] = params[:phi] if params[:phi]
          whitelisted[:date] = params[:date] if params[:date]
        end
      end
    end
  end
end
