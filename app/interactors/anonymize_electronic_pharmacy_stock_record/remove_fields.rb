require 'rubyXL/convenience_methods/cell'

module AnonymizeElectronicPharmacyStockRecord
  class RemoveFields
    include Interactor

    OFFUSCATED_TEXT = 'Not available'.freeze
    INVALID_DATE = 'Invalid date format'.freeze
    FORMATS = {
      DDMMYYYY: '%d%m%Y',
      MMDDYYYY: '%m%d%Y',
      DDMMMYYYY: '%d%b%Y'
    }.freeze

    def call # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      return if context.patient_ids

      (first_row..last_row).to_a.each do |row_number|
        columns_to_offuscate.each do |column_number|
          update_cell(row_number - 1, column_number, OFFUSCATED_TEXT)
        end

        date_columns.each do |column|
          date_format, column_number = column
          parsed_date =
            parse_date(read_cell(row_number, column_number), date_format)
          if parsed_date
            update_cell(row_number - 1, column_number,
                        parsed_date.beginning_of_month.strftime('%d/%m/%Y'))
          else
            update_cell(row_number - 1, column_number, INVALID_DATE)
          end
        end
      end
    end

    private

    def parse_date(date, format)
      Date.strptime(date, FORMATS[format.to_sym])
    rescue ArgumentError, TypeError
      nil
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
        content
      )
    end

    def date_columns
      @date_columns ||=
        context.electronic_pharmacy_stock_record.date.each_with_index.select { |c| c[0] }
    end

    def columns_to_offuscate # rubocop:disable Metrics/AbcSize
      return @columns_to_offuscate if @columns_to_offuscate

      if context.electronic_pharmacy_stock_record.phi.is_a? Array
        return @columns_to_offuscate =
                 context.electronic_pharmacy_stock_record.phi.each_with_index.select { |c| c[0] }.map(&:last)
      end
      @columns_to_offuscate =
        context.electronic_pharmacy_stock_record.phi.values.each_with_index.select { |c| c[0] }.map(&:last)
    end

    def first_row
      @first_row ||= context.electronic_pharmacy_stock_record.data_rows_from
    end

    def last_row
      @last_row ||= context.electronic_pharmacy_stock_record.data_rows_to
    end
  end
end
