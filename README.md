# Ruby MRI bindings for Morfologik

Morfologik is Polish morphological analyzer and Java libraries interfacing it.
See http://sourceforge.net/projects/morfologik/ and http://morfologik.blogspot.com/ for more 
details.

Binding is realized via running .jar file by executing shell command.


## Requirements

With this gem Morfologik library in version 1.5.2 is included.
Java and command `java` is required. 

Code was tested only with Ruby MRI 1.9. 

## Installation

From gem repository:

    $ gem install morfologik

Or download source code and run:

    $ rake test build install

## Usage

Basic usage with `#stem` or `#lemmatize` method:

    Morfologik.new.stem("ma")
    # => { 
    # "ma" => [ 
    #  {
    #        :stem => "mieć",
    #    :category => "verb",
    #      :values => [
    #        { "tense" => "fin", "number" => "sg", "person" => "ter", "aspect" => "imperf" }
    #      ]
    #  },
    #  {
    #        :stem => "mój",
    #    :category => "adj",
    #      :values => [
    #        { "number" => "sg", "case" => "nom", "gender" => "f", "degree" => "pos" },
    #        { "number" => "sg", "case" => "voc", "gender" => "f", "degree" => "pos" }
    #      ]
    #  }
    # }

If only stems or categories are needed, use `#stem_simple` or `#categories` method respectively.

Tags are grouped into categories compatible with output using in PSI-Toolkit Morfologik-based
lemmatizer (see http://psi-toolkit.wmi.amu.edu.pl/)

More examples in documentation and test units.
