require_relative '../enumerables'

describe 'Enumerables' do
  let(:numeric_arr) { [1, 2, 3, 4] }
  let(:mix_arr) { ['Skip', 100, 'Shanon', -100] }
  let(:str_arr) { ['MJ23', 'Lebron', 'Ja', 'Luka Dončič', 'Devin Booker'] }
  let(:is_int) { proc { |int| int.is_a? Integer } }

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
      expect(numeric_arr.my_each_with_index).to be_an(Enumerator)
    end
  end

  describe '#my_select' do
    let(:criteria) { proc { |elem| elem > 3 } }
    let(:range) { Range.new(0, 9) }
    it 'returns an enumerator with elements that meets the criteria' do
      expect(range.my_select(&criteria)).to eq(range.select(&criteria))
    end

    it 'returns enumeratos when block is not given' do
      expect(numeric_arr.my_select).to be_an(Enumerator)
    end
  end

  describe '#my_all?' do
    it 'returns true if all the array is Integer values' do
      expect(numeric_arr.my_all?(&is_int)).to eq(numeric_arr.all?(&is_int))
    end

    it 'returns false if at least one value is not an Interger' do
      expect(mix_arr.my_all?(&is_int)).to eq(mix_arr.all?(&is_int))
    end

    context 'when argument is a class' do
      it 'returns true if all the elements belong to a class' do
        expect(str_arr.my_all?(String)).to be str_arr.all?(String)
      end

      it 'returns false if not all the elements belong to a class' do
        expect(mix_arr.my_all?(String)).to be mix_arr.all?(String)
      end
    end
  end
end
