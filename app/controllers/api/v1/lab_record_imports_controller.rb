module Api
  module V1
    class LabRecordImportsController < ApplicationController
      def create # rubocop:disable Metrics/MethodLength
        lab_record_import = build_lab_record_import

        if lab_record_import.save
          InsertLabRecordsWorker.perform_async( # rubocop:disable Style/MultilineIfModifier
            lab_record_import.id,
            params[:lab_records_attributes]
          ) unless lab_record_import.skip_obfuscation?

          render json: {
            id: lab_record_import.id,
            created_at: lab_record_import.created_at,
            updated_at: lab_record_import.updated_at
          }, status: :created
        else
          render json: lab_record_import.errors, status: :unprocessable_entity
        end
      end

      def update
        interactor = LabRecordImports::Update.call(
          lab_record_import: LabRecordImport.find(params[:id]),
          params: update_permitted_params
        )

        if interactor.valid?
          render json: interactor.lab_record_import, status: :accepted
        else
          render json: interactor.errors, status: :unprocessable_entity
        end
      end

      private

      def build_lab_record_import
        lab_record_import = LabRecordImport.create(permitted_params)
        lab_record_import.patient_id_state = lab_record_import.skip_obfuscation? ? 'obfuscated' : 'pending' # rubocop:disable Metrics/LineLength
        lab_record_import
      end

      def update_permitted_params
        params.tap do |whitelisted|
          whitelisted[:rows] = params[:rows] if params[:rows]
        end
      end

      def permitted_params # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
        params.permit(
          :name, :header_row, :data_rows_from, :data_rows_to, :sheet_file, :site_id, :file_name
        ).tap do |whitelisted|
          whitelisted[:rows] = params[:rows] if params[:rows]
          whitelisted[:columns] = params[:columns] if params[:columns]
          whitelisted[:patient_or_lab_record_id] = params[:patient_or_lab_record_id] if params[:patient_or_lab_record_id] # rubocop:disable Metrics/LineLength
          whitelisted[:phi] = params[:phi] if params[:phi]
          whitelisted[:date] = params[:date] if params[:date]
          whitelisted[:uploaded_at] = params[:created_at] if params[:created_at]
        end
      end
    end
  end
end
