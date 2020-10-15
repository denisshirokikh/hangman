class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  def errors
    @user_guesses - normalized_letters
  end

  def errors_made
    errors.length
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    @letters.map do |letter|
      letter if @user_guesses.include?(normalize_letter(letter))
    end
  end

  def lost?
    errors_allowed.zero?
  end

  def normalize_letter(letter)
    return 'И' if letter == 'Й'
    return 'Е' if letter == 'Ё'

    letter
  end

  def normalized_letters
    @letters.map(&method(:normalize_letter))
  end

  def over?
    won? || lost?
  end

  def play!(letter)
    unless over? || @user_guesses.include?(normalize_letter(letter))
      @user_guesses << normalize_letter(letter)
    end
  end

  def won?
    (normalized_letters - @user_guesses).empty?
  end

  def word
    @letters.join
  end
end
