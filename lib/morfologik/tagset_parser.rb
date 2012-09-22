class Morfologik
  class TagsetParser
  
    TAGS = {
      "adj" => "pos",
      "adja" => "pos",
      "adjp" => "pos",
      "adv" => "pos",
      "num" => "pos",
      "ppron12" => "pos",
      "ppron3" => "pos",
      "pred" => "pos",
      "prep" => "pos",
      "siebie" => "pos",
      "subst" => "pos",
      "verb" => "pos",
      "conj" => "pos",
      "qub" => "pos",
      "burk" => "pos",    # bound word
      "interj" => "pos",  # interjection
      "interp" => "pos",  # interpunction
      "xxx" => "pos",     # alien
      "brev" => "pos",    # abbreviation
      "nie" => "pos",
      "ign" => "pos",
      "sg" => "number",
      "pl" => "number",
      "pltant" => "number",
      "nom" => "case",
      "gen" => "case",
      "acc" => "case",
      "dat" => "case",
      "inst" => "case",
      "loc" => "case",
      "voc" => "case",
      "pos" => "degree",
      "comp" => "degree",
      "sup" => "degree",
      "m" => "gender",
      "m1" => "gender",
      "m2" => "gender",
      "m3" => "gender",
      "m4" => "gender",
      "n" => "gender",
      "f" => "gender",
      "n1" => "gender",
      "n2" => "gender",
      "p1" => "gender",
      "p2" => "gender",
      "p3" => "gender",
      "pri" => "person",
      "sec" => "person",
      "ter" => "person",
      "depr" => "depreciativity",
      "winien" => "winien",
      "aff" => "negation",
      "neg" => "negation",
      "perf" => "aspect",
      "imperf" => "aspect",
      "?perf" => "aspect",
      "nakc" => "accentability",
      "akc" => "accentability",
      "praep" => "post-prepositionality",
      "npraep" => "post-prepositionality",
      "ger" => "tense",
      "imps" => "tense",
      "inf" => "tense",
      "fin" => "tense",
      "bedzie" => "tense",
      "praet" => "tense",
      "refl" => "tense",
      "pact" => "tense",
      "pant" => "tense",
      "pcon" => "tense",
      "ppas" => "tense",
      "impt" => "mode",
      "pot" => "mode",
      "indecl" => "uninflected",
      "irreg" => "irregularity",
      "pun" => "fullstoppedness",
      "npun" => "fullstoppedness",
      "wok" => "vocalicity",
      "nwok" => "vocalicity",
      "agl" => "agglutination",
      "nagl" => "agglutination",
      "_" => "unknown",
      "congr" => "unknown",
      "rec" => "unknown"
    }

    def parse(raw_tags)
      tags = raw_tags.split(':')

      category = find_part_of_speech(tags)
      values = split_tags(tags)

      return category, values
    end

    private

    def find_part_of_speech(tags)
      tags.shift
    end

    def split_tags(tags)
      atom_tags = tags.map { |t| t.split('.') }
      all = atom_tags.inject(1) { |c,t| c * t.size }

      atom_tags.each_with_index do |tags, i|
        atom_tags[i] += tags while atom_tags[i].size < all
      end

      result = []
      all.times do |i|
       result << atom_tags.map { |t| t[i] }.inject({}) { |hsh, t| hsh[TAGS[t]] = t; hsh }
      end

      return result
    end

  end
end
