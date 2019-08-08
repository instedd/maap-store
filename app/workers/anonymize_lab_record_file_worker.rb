class AnonymizeLabRecordFileWorker
  include Sidekiq::Worker

  def perform(lab_record_id)
    @lab_record_id = lab_record_id
    logger.info "Starting anonymization of #{lab_record.id}"

    AnonymizeLabRecordFile::Organizer.call(lab_record: lab_record)

    logger.info "Finished anonymization of #{lab_record.id}"
    # Do something
  end

  private

  def lab_record
    @lab_record ||= LabRecord.find(@lab_record_id)
  end
end
