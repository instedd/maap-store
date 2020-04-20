class InsertLabRecordsWorker
  include Sidekiq::Worker

  def perform(lab_record_import_id)
    Rails.logger.info lab_record_import_id
    @lab_record_import_id = lab_record_import_id
    import_lab_records
    AnonymizeLabRecordImportWorker.perform_async(lab_record_import.id)
  end

  private

  def import_lab_records # rubocop:disable Metrics/AbcSize
    return if lab_record_import.skip_obfuscation?

    lab_records_attributes = JSON.parse(lab_record_import.lab_records_attributes_file.download)
    lab_records_attributes.each do |lab_record_attributes|
      lab_record = LabRecord.new(lab_record_attributes)
      lab_record.site = lab_record_import.site
      lab_record.lab_record_import = lab_record_import
      next lab_record unless lab_record_import.patient_id_index

      lab_record.patient_id = lab_record.content[lab_record_import.patient_id_index]['w']
      lab_record.save
    end
    lab_record_import.lab_records_attributes_file.purge_later
  end

  def lab_record_import
    @lab_record_import ||= LabRecordImport.find(@lab_record_import_id)
  end
end
