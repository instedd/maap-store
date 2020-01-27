module Sheets
  class SaveSheet
    include Interactor

    def call # rubocop:disable Metrics/AbcSize
      file_id = (context.record.site_id || 'unknown-site').to_s
      filename = "#{file_id}-#{context.record.file_name}"

      save_file!
      context.record.sheet_file.attach(
        io: File.open(context.sheet_path),
        filename: "#{filename}.#{file_extension}"
      )
      context.record.save!
    end

    private

    def save_file!
      return save_xls if context.sheet_type == :xls
      return save_xlsx if context.sheet_type == :xlsx

      save_csv
    end

    def save_csv
      CSV.open(context.sheet_path, 'wb') { |csv| context.sheet_file.each { |row| csv << row } }
    end

    def save_xls
      save_xlsx
    end

    def save_xlsx
      context.sheet_path = "#{context.sheet_path}.xlsx"
      context.sheet_file.write(context.sheet_path)
    end

    def file_extension
      context.sheet_type.to_s
    end
  end
end
