require 'rubyXL/convenience_methods/cell'

module AnonymizeLabRecordImport
  class ObfuscatePatientIds
    include Interactor

    def call # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      return if !context.patient_ids || context.record.skip_obfuscation?

      header_cell =
        read_cell(
          context.record.header_row - 1, context.record.patient_id_index
        ).to_s
      if header_cell.empty?
        update_cell(
          context.record.header_row - 1,
          context.record.patient_id_index,
          'Patient Id'
        )
      end
      context.record.lab_records.obfuscated.order(row: :asc).find_each do |lab_record|
        Rails.logger.info "Lab record #{lab_record.id} #{lab_record.row}"

        update_cell(
          mapped_row_number(lab_record),
          context.record.patient_id_index,
          lab_record.patient_id
        )
      end
    end

    private

    def mapped_row_number(lab_record)
      lab_record.row + context.record.data_rows_from - 1
    end

    def read_cell(row, col)
      return read_xlsx(row, col) if context.sheet_type == :xlsx
      return read_xls(row, col) if context.sheet_type == :xls

      read_csv(row, col)
    end

    def read_csv(row, col)
      context.sheet_file[row][col]
    end

    def read_xls(row, col)
      context.current_sheet[row, col]
    end

    def read_xlsx(row, col)
      context.current_sheet[row][col].value
    end

    def update_cell(row, col, content)
      return update_cell_xlsx(row, col, content) if context.sheet_type == :xlsx
      return update_cell_xls(row, col, content) if context.sheet_type == :xls

      update_cell_csv(row, col, content)
    end

    def update_cell_csv(row, col, content)
      context.sheet_file[row][col] = content
    end

    def update_cell_xls(row, col, content)
      context.current_sheet[row, col] = content
    end

    def update_cell_xlsx(row, col, content)
      context.current_sheet[row][col].change_contents(
        '',
        "\"#{content}\""
      )
    end

    def first_row
      @first_row ||= context.record.data_rows_from
    end

    def last_row
      @last_row ||= context.record.data_rows_to
    end
  end
end
