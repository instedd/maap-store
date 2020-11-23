class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :lab_record_imports_tags, dependent: :restrict_with_error
  has_many :lab_record_imports, through: :lab_record_imports_tags
end
