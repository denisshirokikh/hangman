class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  def errors
    return @user_guesses - @letters
  end

  def errors_made
    return errors.length
  end

  def errors_allowed
    return TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    result =
      @letters.map do |letter|
        if normalized_letters(@user_guesses).include?(normalized_letter(letter))
          letter
        else
          nil
        end
      end

    return result
  end

  def lost?
    return errors_allowed == 0
  end

  def normalized_letter(letter)
    case letter
      when "Ё" then return "Е"
      when "Й" then return "И"
      else
        letter
    end
  end

  def normalized_letters(letters)
    letters.map do |letter|
      normalized_letter(letter)
    end
  end

  def over?
    return won? || lost?
  end

  def play!(letter)
    if !over? && !normalized_letters(@user_guesses).include?(normalized_letter(letter))
      @user_guesses << letter
    end
  end

  def won?
    return (@letters - @user_guesses).empty?
  end

  def word
    return @letters.join
  end
end
