# require_relative '../enumerables.rb'

describe 'Enumerables' do
  let(:numeric_arr) { [1, 2, 3, 4] }

  describe '#my_each' do
    it 'simulates the normal #each in ruby' do
      expect(numeric_arr.my_each { |el| (el * 5) }).to eq(numeric_arr.each { |i| i.send('*', 5) })
    end

    it 'returns enumerator when no block is given' do
      expect(numeric_arr.my_each).to be_an(Enumerator)
    end
  end
end
