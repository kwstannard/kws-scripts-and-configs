require 'rspec-advanced_subject'
require 'repo_helper'
require 'fuzzy_branch'

describe FuzzyBranch do
  describe '#call' do
    with_args 'dev' do
      context 'dev exists' do
        before { repo.create_branch 'dev' }
        it { is_expected.to eq('dev') }
      end

      context 'dev doesnt exist' do
        it { is_expected.to eq('master') }
      end
    end
  end
end
