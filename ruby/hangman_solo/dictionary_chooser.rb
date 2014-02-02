class DictionaryChooser

  def initialize(dictionary)
    @dictionary = dictionary
  end

  def random_word
    @dictionary.sample
  end

end
