class ElectronicPharmacyStockRecord < ApplicationRecord
  belongs_to :site
  has_one_attached :sheet_file
  has_one_attached :rows_file

  enum obfuscation_state: {
    pending: 0,
    obfuscated: 1,
    error: 2
  }

  def name
    id
  end

  def obfuscated?
    obfuscation_state == 'obfuscated'
  end

  def error?
    obfuscation_state == 'error'
  end

  def columns
    JSON[self[:columns]]
  end

  def phi
    JSON[self[:phi]]
  end

  def date
    JSON[self[:date]]
  end

  def skip_obfuscation?
    phi.empty?
  end
end
