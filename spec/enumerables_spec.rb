require_relative '../enumerables'

describe 'Enumerables' do
  let(:numeric_arr) { [1, 2, 3, 4] }

  describe '#my_each' do
    it 'simulates normal #each in ruby' do
      expect(numeric_arr.my_each { |el| (el * 5) }).to eq(numeric_arr.each { |i| i.send('*', 5) })
    end

    it 'returns enumerator when block is not given' do
      expect(numeric_arr.my_each).to be_an(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'simulates normal each in ruby with index' do
      expect(numeric_arr.my_each_with_index { |el, i| el + i }).to eq(numeric_arr.each_with_index { |el, i| el + i })
    end

    it 'returns enumerator when block is not given' do
      expect(numeric_arr.my_each).to be_an(Enumerator)
    end
  end
end
