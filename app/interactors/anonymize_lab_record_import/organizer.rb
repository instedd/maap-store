module AnonymizeLabRecordImport
  class Organizer
    include Interactor::Organizer

    organize Sheets::ReadSheet,
             AnonymizeLabRecordImport::ObfuscatePatientIds,
             Sheets::RemoveFields,
             Sheets::SaveSheet,
             Sheets::PruneTableFields,
             S3::Upload

    def call # rubocop:disable AbcSize
      super
    rescue StandardError => e
      return context unless context.state_attribute && context.record

      context.record[context.state_attribute] = :error
      context.record.error_message = 'Unknown error'
      context.record.raw_error_message = e.inspect
      context.record.save!
      context
    end
  end
end
