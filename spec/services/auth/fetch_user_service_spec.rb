RSpec.describe Auth::FetchUserService do
  subject { described_class }

  context 'valid parameters' do
    let(:session) { create(:user_session) }

    it 'assigns user' do
      result = subject.call(session.uuid)

      expect(result.user).to eq(session.user)
    end
  end

  context 'invalid parameters' do
    it 'does not assign user' do
      result = subject.call('invalid')

      expect(result.user).to be_nil
    end

    it 'adds an error' do
      result = subject.call('invalid')

      expect(result).to be_failure
      expect(result.errors).to include('Доступ к ресурсу ограничен')
    end
  end
end
