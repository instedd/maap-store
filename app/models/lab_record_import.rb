class LabRecordImport < ApplicationRecord
  belongs_to :site
  has_one_attached :sheet_file
  has_one_attached :rows_file
  has_many :lab_records, dependent: :destroy
  has_many :lab_record_imports_tags, dependent: :destroy
  has_many :tags, through: :lab_record_imports_tags

  # accepts_nested_attributes_for :lab_records

  def name
    id
  end

  def error?
    patient_id_state == 'error'
  end

  def obfuscated?
    patient_id_state == 'obfuscated'
  end

  def columns
    JSON[self[:columns]]
  end

  def patient_or_lab_record_id
    JSON[self[:patient_or_lab_record_id]]
  end

  def phi
    JSON[self[:phi]]
  end

  def date
    JSON[self[:date]]
  end

  def patient_id_index
    patient_or_lab_record_id.index('patientId').to_i
  end

  def skip_obfuscation?
    patient_or_lab_record_id.empty? || phi.empty?
  end
end
