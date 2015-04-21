require 'spec_helper'
describe 'servioticy' do

  context 'with defaults for all parameters' do
    it { should contain_class('servioticy') }
  end
end
