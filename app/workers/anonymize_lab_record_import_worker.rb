class AnonymizeLabRecordImportWorker
  include Sidekiq::Worker

  sidekiq_options retry: 3

  def perform(lab_record_import_id)
    @lab_record_import_id = lab_record_import_id
    logger.info "Starting anonymization of #{lab_record_import.id}"

    InteractorsLRI::Organizer.call(
      record: lab_record_import,
      state_attribute: :patient_id_state
    )

    logger.info "Finished anonymization of #{lab_record_import.id}"
  end

  private

  def lab_record_import
    @lab_record_import ||= LabRecordImport.find(@lab_record_import_id)
  end
end
