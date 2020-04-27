module Sheets
  class PruneTableFields
    include Interactor

    def call
      Rails.logger.info "Pruning raw rows for record #{context.record.class} #{context.record.id}"
      context.record.rows = {}
      send_to_obfuscated_state!
      context.record.save!
    end

    private

    def send_to_obfuscated_state!
      context.record[context.state_attribute] = :obfuscated if context.obfuscate_on_finish || context.record.skip_obfuscation? # rubocop:disable Metrics/LineLength
    end
  end
end
