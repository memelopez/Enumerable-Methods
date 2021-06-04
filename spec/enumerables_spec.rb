require_relative '../enumerables'

describe 'Enumerables' do
  let(:numeric_arr) { [1, 2, 3, 4] }
  let(:mix_arr) { ['Skip', 100, 'Shanon', -100] }
  let(:str_arr) { ['Micheal Jordan', 'Lebron', 'Ja Morant', 'Luka Dončič', 'Devin Booker'] }
  nil_arr = [nil, nil, false]
  let(:is_int) { proc { |int| int.is_a? Integer } }
  let(:grtr_than3) { proc { |elem| elem > 3 } }

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

    context 'when no block is given' do
      it 'returns true if all the elements evaluate to true in the array' do
        expect(numeric_arr.my_all?).to be numeric_arr.all?
      end

      it 'returns false if an element in the array evaluates to false' do
        numeric_arr << nil
        expect(numeric_arr.my_all?).to be numeric_arr.all?
      end
    end

    context 'when a regex is passed as an argument' do
      it 'returns true if all the elements match the regex expression' do
        expect(str_arr.my_all?(/o/)).to be_truthy
      end

      it 'returns false if at least one of the elements does not match the regex expression' do
        expect(str_arr.my_all?(/i/)).to be_falsey
      end
    end
  end

  describe '#my_any?' do
    it 'returns true if at least one element un the array meets the criteria' do
      expect(mix_arr.my_any?(&is_int)).to eq(mix_arr.any?(&is_int))
    end

    it 'returns false only if none of the elements in the array meet the criteria' do
      expect(str_arr.my_any?(&is_int)).to eq(str_arr.any?(&is_int))
    end

    context 'when argument is a class' do
      it 'returns true if at leat one element belong to the class' do
        expect(mix_arr.my_any?(String)).to eq(mix_arr.any?(String))
      end

      it 'returns false only if none of the elements belong to the class' do
        expect(numeric_arr.my_any?(String)).to eq(numeric_arr.any?(String))
      end
    end

    context 'when no block or argument is given' do
      it 'returns true if any of the elements in the array evaluate to true' do
        expect(numeric_arr.my_any?).to be numeric_arr.any?
      end

      it 'returns false only if none of the elements in the array evaluate to true' do
        expect(nil_arr.my_any?).to be nil_arr.any?
      end
    end

    context 'when a regex is passed as an argument' do
      it 'returns true if at least one element in the array mathces the regex expression' do
        expect(str_arr.my_any?(/J/)).to be_truthy
      end

      it 'returns false only if none of the elements in the array mathces the regex expression' do
        expect(str_arr.my_any?(/!/)).to be_falsey
      end
    end
  end

  describe '#my_none?' do
    it 'returns if none of the elements in the array evaluate to true' do
      expect(str_arr.my_none?(&is_int)).to eq(str_arr.none?(&is_int))
    end

    it 'returns false if at least one of the elements in the array evaluates to true' do
      expect(mix_arr.my_none?(&is_int)).to eq(mix_arr.none?(&is_int))
    end

    context 'when no block or argument is given' do
      it 'returns true if none of the elements evaluate to true' do
        expect(nil_arr.my_none?).to be nil_arr.none?
      end

      it 'returns false if at least one of the elements in the array evaluates to true' do
        expect(numeric_arr.my_none?).to be numeric_arr.none?
      end
    end

    context 'when a regex is passed as an argument' do
      it 'returns true if none of the elements in the array match the regular expression' do
        expect(str_arr.my_none?(/!/)).to be_truthy
      end

      it 'returns false if at least one of the elements match the regular expression' do
        expect(str_arr.my_none?(/M/)).to be_falsey
      end
    end
  end

  describe '#my_count' do
    it 'returns the number of elements that are equal to the argument' do
      expect(numeric_arr.my_count(2)).to eq(numeric_arr.count(2))
    end

    it 'returns the number of elements inside an array that meet the criteria' do
      expect(numeric_arr.my_count(&grtr_than3)).to eq numeric_arr.count(&grtr_than3)
    end
  end
end
