class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  def errors
    @user_guesses - @letters
  end

  def errors_made
    errors.length
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    @letters.map { |letter| letter if @user_guesses.include?(normalized_letter(letter)) }
  end

  def lost?
    errors_allowed == 0
  end

  def normalized_letter(letter)
    case letter
    when "Ё" then return "Е"
    when "Й" then return "И"
    else letter
    end
  end

  def normalized_letters(letters)
    letters.map do |letter|
      normalized_letter(letter)
    end
  end

  def over?
    won? || lost?
  end

  def play!(letter)
    if !over? && !normalized_letters(@user_guesses).include?(normalized_letter(letter))
      @user_guesses << normalized_letter(letter)
    end
  end

  def won?
    (@letters - @user_guesses).empty?
  end

  def word
    @letters.join
  end
end
