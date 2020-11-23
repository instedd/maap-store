require 'rails_helper'

RSpec.describe LabRecordImport, type: :model do
  it 'skips obfuscation if patient_or_lab_record_id is empty' do
    import_without_patient_lab_id = create(:lab_record_import, patient_or_lab_record_id: '[]')

    expect(import_without_patient_lab_id.skip_obfuscation?).to eq(true)
  end

  it 'skips obfuscation if phi is empty' do
    import_without_phi = create(:lab_record_import, phi: '[]')

    expect(import_without_phi.skip_obfuscation?).to eq(true)
  end

  it 'obfuscates if both `patient_or_lab_record_id` and `phi` are non-empty' do
    expect(create(:lab_record_import).skip_obfuscation?).to eq(false)
  end

  it { is_expected.to have_many(:tags).through(:lab_record_imports_tags) }
  it { is_expected.to have_many(:lab_record_imports_tags).dependent(:destroy) }
end
