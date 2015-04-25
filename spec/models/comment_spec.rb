require 'rails_helper'

describe Comment, type: :model do
  it { is_expected.to belong_to :article }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of :text }
  it { is_expected.to validate_presence_of :article }
  it { is_expected.to validate_presence_of :user }
end
