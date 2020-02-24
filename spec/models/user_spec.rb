require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'create' do
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
      end
    end
  end
  describe 'update' do
    let(:temp_user) { create(:temp_user, :with_area) }
    let(:params) { attributes_for(:formal_user) }
    describe 'Validates' do
      it 'shold be valid' do
        temp_user.update!(params)
        expect(temp_user.errors).to be_empty
      end
      describe 'email' do
        it 'should be present' do
          params[:email] = ''
          expect{ temp_user.update!(params) }.to raise_error ActiveRecord::RecordInvalid
        end
      end
      describe 'password' do
        it 'should be present' do
          params[:password] = ''
          expect{ temp_user.update!(params) }.to raise_error ActiveRecord::RecordInvalid
        end
        it 'confirmation should be present' do
          params[:password_confirmation] = ''
          expect{ temp_user.update!(params) }.to raise_error ActiveRecord::RecordInvalid
        end
        it 'not should be invalid' do
          params[:password_confirmation] = 'pass'
          expect{ temp_user.update!(params) }.to raise_error ActiveRecord::RecordInvalid
        end
      end
    end
  end
end
