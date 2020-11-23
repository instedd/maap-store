class LabRecordImportsTag < ApplicationRecord
  belongs_to :lab_record_import
  belongs_to :tag

  validates :tag_id, uniqueness: { scope: [:lab_record_import_id] }
end
