require 'set'
require 'byebug'

class WordChainer
  def initialize(dictionary_file_name)
    @dictionary =make_dictionary(dictionary_file_name)
  end

  def make_dictionary(dictionary_file_name)
    File.readlines(dictionary_file_name).map {|line| line.chomp}.to_set
  end

  def adjacent_word(word)
    adjacent_words = []
    word.each_char.with_index do |letter, new_idx|
      ('a'..'z').each do |new_letter|
        new_word = ""
        word.length.times do |idx|
          if idx == new_idx
            new_word += new_letter
          else
            new_word += word[idx]
          end
        end
        adjacent_words << new_word if @dictionary.include?(new_word)
      end
    end
    adjacent_words
  end

  def run(source, target)
    @current_words = {source => nil}
    @all_seen_words = {source => nil}
    until @current_words.empty?
      explore_current_words(target)
    end
    p build_path(target)
  end

  def build_path(target)
    if target == nil
      []
    else
      parent = @all_seen_words.select { |k, v| k == @all_seen_words[target]}
      path = build_path(parent.keys[0])
      path << target
      path
      end
  end

  def explore_current_words(target)
    new_current_words = {}
    @current_words.each do |current_word, current_parent|
      adjacent_word(current_word).each do |new_word, new_parent|
        unless @all_seen_words.include?(new_word) || @all_seen_words.include?(target)
          new_current_words[new_word] = current_word
          @all_seen_words[new_word] = current_word
        end
      end
    end
    @current_words = new_current_words
    new_current_words.each do |new_current, new_current_parent|
      # p "new: #{new_current}, parent: #{new_current_parent}"
    end
  end
end

test = WordChainer.new('dictionary.txt')
test.run('duck', 'ruby')
# test.adjacent_word('duck')
# test.build_path('ruby')
