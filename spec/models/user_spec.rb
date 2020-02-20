require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user, :with_area) }
  describe 'Validates' do
    it 'shold be valid' do
      expect(user).to be_valid
    end
    describe 'name' do
      it 'should be proper long' do
        user.name = 'a' * 20
        expect(user).to be_valid
      end
      it 'should not be too long' do
        user.name = 'a' * 21
        expect(user).not_to be_valid
      end
    end
    describe 'email' do
      it 'should be present' do
        user.email = ''
        expect(user).not_to be_valid
      end
      it 'should be proper long' do
        user.email = 'a' * 243 + '@example.com'
        expect(user).to be_valid
      end
      it 'should not be too long' do
        user.email = 'a' * 244 + '@example.com'
        expect(user).not_to be_valid
      end
      it 'addresses should be unique' do
        duplicate_user = build(:user, email: user.email)
        user.save
        expect(duplicate_user).not_to be_valid
      end
      # it 'addresses should be alphabetically unique' do
      #   user = create(:user, email: 'JO@examPle.COM')
      #   duplicate_user = build(:user, email: user.email.downcase)
      #   expect(duplicate_user).not_to be_valid
      # end
      # it 'saves only downcase email' do
      #   user = create(:user, email: 'JO@examPle.COM')
      #   expect(user.reload.email).to eq 'jo@example.com'
      # end
    end
    describe 'password' do
      it 'should be present' do
        user.password = ''
        user.password_confirmation = ''
        expect(user).not_to be_valid
      end
      it 'confirmation should be present' do
        user.password_confirmation = ''
        expect(user).not_to be_valid
      end
      it 'not should be invalid' do
        user.password = 'password'
        user.password_confirmation = 'pass'
        expect(user).not_to be_valid
      end
    end
  end
end
