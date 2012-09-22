#encoding:utf-8
 
require 'pathname'
require 'open3'
require 'awesome_print'

require 'morfologik/output_parser' 

class Morfologik

  attr_reader :jar

  def initialize(options={})
    @jar = options[:jar] || default_jar
    raise LoadError, "Morfologik .jar file not found" unless jar_file_exists?

    @output_parser = OutputParser.new
    @ie = options[:input_encoding] || 'UTF-8'
    @oe = options[:output_encoding] || 'UTF-8'
  end

  # Stems words giving their stems, categories and tags.
  #
  # @param [String, Array<String>] words words to stem
  # @return [Hash] analysis for each recognized word
  # @example
  #   Morfologik.new.stem("ma")
  #   # => { 
  #     "ma" => [ 
  #      {
  #            :stem => "mieć",
  #        :category => "verb",
  #          :values => [
  #            { "tense" => "fin", "number" => "sg", "person" => "ter", "aspect" => "imperf" }
  #          ]
  #      },
  #      {
  #            :stem => "mój",
  #        :category => "adj",
  #          :values => [
  #            { "number" => "sg", "case" => "nom", "gender" => "f", "degree" => "pos" },
  #            { "number" => "sg", "case" => "voc", "gender" => "f", "degree" => "pos" }
  #          ]
  #      }
  #   }
  def stem(words)
    output = run_jar(words.kind_of?(String) ? words.split : words)
    @output_parser.parse(output)
  end

  alias_method :lemmatize, :stem

  # Stems words giving only their stems.
  #
  # @param (see #stem)
  # @return [Hash] stems for each recognized word
  # @example
  #   # => { "ma" => [ "mieć", "mój" ] }
  def stem_simple(words)
    output = run_jar(words.kind_of?(String) ? words.split : words)
    @output_parser.parse_stems_only(output)
  end

  alias_method :lemmatize_simple, :stem_simple

  def categories(words)
    output = run_jar(words.kind_of?(String) ? words.split : words)
    @output_parser.parse_categories_only(output)
  end

  # Checks if given words have at least one common stem. Returns nil if analysis fail.
  #
  # @param [String] *words words to check
  # @return [true, false, nil]
  def equal_stems?(*words)
    return nil if words.uniq.size < 2
    
    stems = @output_parser.parse_stems_only(run_jar(words))
    return nil unless words.uniq.size == stems.keys.size
    
    not stems.values.inject(&:&).empty?
  end

  private

  def run_jar(words)
    cmd = "echo '#{words.uniq.join(' ')}' | java -jar #{@jar} plstem -ie #{@ie} -oe #{@oe}"

    result = []
    Open3.popen3(cmd) do |i, o, e, t| 
      o.each_line { |line| result << line unless line.start_with?('Processed') }
    end

    return result
  end

  def jar_file_exists?
    File.exists?(@jar) and File.extname(@jar) == '.jar'
  end

  def default_jar
    path = File.dirname(__FILE__) + '/morfologik/jar/morfologik-tools-1.5.2-standalone.jar'
    Pathname.new(path).realpath.cleanpath.to_s
  end

end
