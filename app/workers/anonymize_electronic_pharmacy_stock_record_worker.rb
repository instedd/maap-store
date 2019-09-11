class AnonymizeElectronicPharmacyStockRecordWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(record_id, patient_ids = false)
    @record_id = record_id
    logger.info "Starting anonymization of #{electronic_pharmacy_stock_record.id}"

    AnonymizeElectronicPharmacyStockRecord::Organizer.call(
      electronic_pharmacy_stock_record: electronic_pharmacy_stock_record,
      patient_ids: patient_ids
    )

    logger.info "Finished anonymization of #{electronic_pharmacy_stock_record.id}"
  end

  private

  def electronic_pharmacy_stock_record
    @electronic_pharmacy_stock_record ||= ElectronicPharmacyStockRecord.find(@record_id)
  end
end