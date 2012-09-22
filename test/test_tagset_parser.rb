#encoding:utf-8

require 'test/unit'
require File.expand_path(File.dirname(__FILE__)) + '/../lib/morfologik'


class TestTagsetParser < Test::Unit::TestCase

  def setup
    @morfologik = Morfologik.new
    @tagset_parser = Morfologik::TagsetParser.new
  end

  def test_parse
    stems = @morfologik.stem("Alicję")
    values = { "number" => "sg", "case" => "acc", "gender" => "f" }

    assert_kind_of Hash, stems["Alicję"].first[:values].first
    assert_equal values, stems["Alicję"].first[:values].first
  end

end
