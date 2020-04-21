module Sheets
  class PurgeRowsFile
    include Interactor

    def call # rubocop:disable Metrics/AbcSize
      Rails.logger.info "Purging rows_file for record #{context.record.class} #{context.record.id}"
      context.record.rows_file.purge_later
      send_to_obfuscated_state!
      context.record.save!
    end

    private

    def send_to_obfuscated_state!
      context.record[context.state_attribute] = :obfuscated if context.obfuscate_on_finish || context.record.skip_obfuscation? # rubocop:disable Metrics/LineLength
    end
  end
end
