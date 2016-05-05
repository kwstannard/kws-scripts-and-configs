require 'rspec-advanced_subject'
require 'pathname'
require Pathname(__FILE__) + '../../lib/modifiable_struct'

describe ModifiableStruct do

  when_initialized_with Hash.new do

    describe '#anything' do

      context 'before setting #anything' do
        it 'raises no method error' do
          expect{subject.anything}.to raise_error(NoMethodError)
        end
      end

      context 'after setting #anything' do
        it 'returns the value' do
          subject.anything = 5
          expect(subject.anything).to eq(5)
        end
      end

    end
  end
end
