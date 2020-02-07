shared_examples_for 'Tokenがおかしい時' do |exist: false, different: false|
  if exist
    it '存在しない 401 Unauthorized' do
      set_not_exist_token
      expect(subject).to eq 401
    end
  end
  if different
    it '異なる 401 Unauthorized' do
      set_different_token
      expect(subject).to eq 401
    end
  end
end
shared_examples_for ':idがおかしい時' do |exist: false, different: false|
  if exist
    it '存在しない RecordNotFound' do
      set_not_exist_id
      expect{ subject }.to raise_error ActiveRecord::RecordNotFound
    end
  end
  if different
    it '異なる時 401 Unauthorized' do
      set_different_id
      expect(subject).to eq 401
    end
  end
end
