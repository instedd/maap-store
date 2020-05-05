module LabRecordImports
  class Update
    include Interactor

    def call # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      ActiveRecord::Base.transaction do
        lab_record_import.rows_file.purge
        lab_record_import.rows_file.attach(params[:rows_file])
        lab_record_import.update!(patient_id_state: :pending)

        rows = open(params[:rows_file].path, 'r') { |file| JSON.load(file) }
        rows.each_with_index do |row, index|
          lab_record_for_row(index).update(
            patient_id: row[patient_id_index]['w'],
            patient_id_state: 'pending'
          )
        end
      end
    end

    private

    def lab_record_for_row(row_number)
      lab_record_import.lab_records.find_by(row: row_number)
    end

    def params
      context.params
    end

    def lab_record_import
      context.lab_record_import
    end

    def patient_id_index
      lab_record_import.patient_id_index
    end
  end
end
