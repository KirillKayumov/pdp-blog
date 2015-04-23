require 'rails_helper'

describe User, type: :model do
  it { is_expected.to validate_presence_of :full_name }
  it { is_expected.to have_many :articles }

  describe '#to_s' do
    let(:user) { create :user, full_name: 'Name Surname' }

    it 'returns full name' do
      expect(user.to_s).to eq('Name Surname')
    end
  end
end
