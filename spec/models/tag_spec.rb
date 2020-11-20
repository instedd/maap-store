require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { build :tag }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to have_many(:lab_record_imports).through(:lab_record_imports_tags) }
  it { is_expected.to have_many(:lab_record_imports_tags).dependent(:restrict_with_error) }
end
