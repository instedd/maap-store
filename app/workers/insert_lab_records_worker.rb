class InsertLabRecordsWorker
  include Sidekiq::Worker

  def perform(lab_record_import_id, lab_records)
    Rails.logger.info lab_record_import_id
    @lab_record_import_id = lab_record_import_id
    @lab_records = lab_records
    import_lab_records
    AnonymizeLabRecordImportWorker.perform_async(lab_record_import.id)
  end

  private

  def parsed_records
    JSON[@lab_records]
  end

  def import_lab_records # rubocop:disable Metrics/AbcSize
    return if lab_record_import.skip_obfuscation?

    parsed_records.each do |lab_record_attributes|
      lab_record = LabRecord.new(lab_record_attributes)
      lab_record.site = lab_record_import.site
      lab_record.lab_record_import = lab_record_import
      next lab_record unless lab_record_import.patient_id_index

      lab_record.patient_id = lab_record.content[lab_record_import.patient_id_index]['w']
      lab_record.save
    end
  end

  def lab_record_import
    @lab_record_import ||= LabRecordImport.find(@lab_record_import_id)
  end
end
