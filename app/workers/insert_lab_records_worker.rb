class InsertLabRecordsWorker
  include Sidekiq::Worker
  include ApplicationHelper

  def perform(lab_record_import_id)
    Rails.logger.info lab_record_import_id
    @lab_record_import_id = lab_record_import_id
    import_lab_records
    AnonymizeLabRecordImportWorker.perform_async(lab_record_import.id)
  end

  private

  def import_lab_records # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    unless lab_record_import.skip_obfuscation?
      blob_key = lab_record_import.lab_records_attributes_file.blob.key
      lab_records_attributes = json_from_active_storage_attachment(blob_key)
      lab_records_attributes.each do |lab_record_attributes|
        lab_record = LabRecord.new(lab_record_attributes)
        lab_record.site = lab_record_import.site
        lab_record.lab_record_import = lab_record_import
        next lab_record unless lab_record_import.patient_id_index

        lab_record.patient_id = lab_record.content[lab_record_import.patient_id_index]['w']
        lab_record.save
      end
    end

    lab_record_import.lab_records_attributes_file.purge_later
  end

  def lab_record_import
    @lab_record_import ||= LabRecordImport.find(@lab_record_import_id)
  end
end
