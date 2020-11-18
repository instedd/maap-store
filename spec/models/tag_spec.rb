require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { build :tag }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
end
