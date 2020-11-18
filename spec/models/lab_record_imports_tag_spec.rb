require 'rails_helper'

RSpec.describe LabRecordImportsTag, type: :model do
  subject do
    l = create(:lab_record_import)
    t = create(:tag)
    build(:lab_record_imports_tag, lab_record_import_id: l.id, tag_id: t.id)
  end

  it { is_expected.to validate_uniqueness_of(:tag_id).scoped_to(:lab_record_import_id) }
end
