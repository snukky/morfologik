#encoding:utf-8

require 'test/unit'
require File.expand_path(File.dirname(__FILE__)) + '/../lib/morfologik'


class TestMorfologik < Test::Unit::TestCase

  def setup
    @morfologik = Morfologik.new
  end

  def test_stem
    stems = @morfologik.stem("ma")

    assert stems.kind_of?(Hash)
    assert_equal stems.keys, ["ma"]
    assert_equal stems["ma"].size, 2

    assert_equal stems["ma"][0][:stem], "mieć"
    assert_equal stems["ma"][0][:category], "verb"
    assert_equal stems["ma"][0][:values].size, 1

    assert_equal stems["ma"][1][:stem], "mój"
    assert_equal stems["ma"][1][:category], "adj"
    assert_equal stems["ma"][1][:values].size , 2
  end

  def test_nonexistent_word
    stems = @morfologik.stem("abcdefghijk")
    assert stems.empty?
  end

  def test_many_words
    stems = @morfologik.stem("Ala ma kota")
    assert_equal stems.keys, ["Ala", "ma", "kota"]
  end

  def test_duplicated_words
    stems = @morfologik.stem("ma ma ma")
    assert_equal stems.size, 1
  end

  def test_input_argument_types
    stems_from_string = @morfologik.stem("ma kota")
    stems_from_array = @morfologik.stem(["ma", "kota"])

    assert_equal stems_from_string, stems_from_array
  end

  def test_stem_simple
    only_stems = @morfologik.stem_simple("Ala ma kota")
    
    only_stems.each_value do |stems|
      assert_equal stems.size, 2
      assert stems.all? { |stem| stem.kind_of?(String) }
    end
  end

  def test_equal_stem
    assert_nil @morfologik.equal_stems?("mój")
    assert_nil @morfologik.equal_stems?("abcd", "efgh")

    assert !@morfologik.equal_stems?("Ala", "kota")
    assert !@morfologik.equal_stems?("mój pies", "mojego psa") # should be true?

    assert @morfologik.equal_stems?("mój", "moja")
    assert @morfologik.equal_stems?("mój", "moja", "moje")
  end

  def test_unique_stem_simple
    stems = @morfologik.stem_simple("mojego")["mojego"]
    assert stems.uniq == stems
  end

end
