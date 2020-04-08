shared_examples_for 'Tokenがおかしい時' do |exist: false, different: false|
  let(:different_user) { create(:user) }
  if exist
    context '存在しない時' do
      let(:options) { { HTTP_AUTHORIZATION: 'Bearer not_exist_token' } }
      it { is_expected.to eq 401 }
    end
  end
  if different
    context '異なる時' do
      let(:options) { { HTTP_AUTHORIZATION: "Bearer #{different_user.token}" } }
      it { is_expected.to eq 403 }
    end
  end
end
