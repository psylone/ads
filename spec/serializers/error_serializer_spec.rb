RSpec.describe ErrorSerializer do
  subject { described_class }

  describe 'from_messages' do
    context 'with single error message' do
      let(:message) { 'Error message' }

      it 'returns errors representation' do
        expect(subject.from_message(message)).to eq(
          errors: [
            { detail: message }
          ]
        )
      end
    end

    context 'with multiple error messages' do
      let(:messages) { ['Error message 1', 'Error message 2'] }

      it 'returns errors representation' do
        expect(subject.from_messages(messages)).to eq(
          errors: [
            { detail: messages[0] },
            { detail: messages[1] }
          ]
        )
      end
    end

    context 'with meta' do
      let(:message) { 'Error message' }
      let(:meta) { { level: 'error' } }

      it 'returns errors representation' do
        expect(subject.from_message(message, meta: meta)).to eq(
          errors: [
            {
              detail: message,
              meta: meta
            }
          ]
        )
      end
    end
  end

  describe 'from_model' do
    let(:model) do
      Class.new do
        include ActiveModel::Model

        attr_accessor :blue, :green

        validates :blue, :green, presence: true
        validates :green, inclusion: { in: [1] }

        def self.name
          'Model'
        end
      end.new
    end

    before do
      model.validate
    end

    it 'returns errors representation' do
      expect(subject.from_model(model)).to eq(
        errors: [
          {
            detail: %(не может быть пустым),
            source: {
              pointer: '/data/attributes/blue'
            }
          },
          {
            detail: %(не может быть пустым),
            source: {
              pointer: '/data/attributes/green'
            }
          },
          {
            detail: %(имеет непредусмотренное значение),
            source: {
              pointer: '/data/attributes/green'
            }
          }
        ]
      )
    end
  end
end
