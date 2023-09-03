require 'pry'

system('clear')
puts "Welcome to Type Teach!"

# Load the config file and initialize config variables
config_filename = 'config.yaml'

require 'yaml'
config = YAML.load_file(config_filename)
letters_include_array = config['letters_include_array'].split
enable_lowercase = config['enable_lowercase']
enable_uppercase = config['enable_uppercase']
prompt_case_upper_only  = config['prompt_case_upper_only']
default_rounds = 5
prompt_amount = 2
characters_per_prompt = 70

prompt_configs = {}
prompt_configs['characters_per_prompt'] = characters_per_prompt
prompt_configs['enable_lowercase'] = enable_lowercase
prompt_configs['enable_uppercase'] = enable_uppercase





# Load and process the dictionary of words
wordbank_filename = config['wordbank_filename']
wordbank_array = File.readlines(wordbank_filename)
wordbank_array.map! { |word| word.chomp }

allowed_words_array = wordbank_array.select do |word|
  word.downcase.split('').all? do |char|
    letters_include_array.include?(char)
  end
end


# Main program
intro_verbiage = <<-STRNG
In this session, each of #{default_rounds} rounds will consist of #{prompt_amount} prompts (sentences). 
We will only test words that use the following lowercase letters:\n#{letters_include_array}.



STRNG


puts intro_verbiage

curr_round_num = 1
curr_prompt_num = 1
prompts_arr = []
responses_arr = []
prompt_intro = <<-STRNG
Round #{curr_round_num}, Prompt #{curr_prompt_num}:
--------------------------------------------------

STRNG



def get_prompt (allowed_words_array,configs)
  prompt_words = ''
  loop do
    next_word = allowed_words_array.sample
    if prompt_words.size + next_word.size + 1 > configs['characters_per_prompt']
      break
    else 
      space = prompt_words.size == 0 ? '' : ' '
      prompt_words << space + next_word
    end
    if configs['enable_lowercase'] && !configs['enable_uppercase']
      prompt_words.downcase!
    elsif
      !['enable_lowercase'] && configs['enable_uppercase']
      prompt_words.upcase!
    end
  end
  prompt_words
end




# Prompt Execution:
until curr_prompt_num > prompt_amount do 
  system('clear')
  curr_prompt = get_prompt(allowed_words_array,prompt_configs)
  puts prompt_intro
  puts curr_prompt
  typed_response = gets.chomp
  responses_arr << typed_response
  curr_prompt_num += 1
end

puts "Program is done. Thanks!"


