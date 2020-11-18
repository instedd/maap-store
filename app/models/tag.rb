class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :lab_record_imports_tags, dependent: :destroy
  has_many :lab_record_imports, through: :lab_record_imports_tags
end
