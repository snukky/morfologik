require 'morfologik/tagset_parser'

class Morfologik
  class OutputParser

    def initialize
      @tagset_parser = TagsetParser.new
    end
    
    def parse(output)
      output.inject({}) do |result, line|
        word, stem, desc = line.split
  
        if stem_found?(stem)
          desc.split('+').each do |tags|
            category, values = @tagset_parser.parse(tags)

            morf = { :stem => stem, :category => category, :values => values }
            result.has_key?(word) ? result[word] << morf : result[word] = [morf]
          end
        end
      
        result
      end
    end  

    def parse_stems_only(output)
      output.inject({}) do |result, line|
        word, stem = line.split[0..1]
        
        if stem_found?(stem)
          result.has_key?(word) ? result[word] << stem : result[word] = [stem]
          result[word].uniq!
        end

        result
      end
    end

    def parse_categories_only(output)
      output.inject({}) do |result, line|
        word, stem, tags = line.split
        
        if stem_found?(stem)
          category = tags.split(':').first
          result.has_key?(word) ? result[word] << category : result[word] = [category]
          result[word].uniq!
        end

        result
      end
    end

    private

    def stem_found?(stem)
      stem != '-'
    end

  end
end
