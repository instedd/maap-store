require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build :user }

  it { is_expected.to validate_presence_of(:email) }

  it { is_expected.to be_valid }
end
