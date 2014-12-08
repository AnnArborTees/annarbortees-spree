class String
  def proper_case
    self.downcase.split(/\s/).collect { |s| s.capitalize }.join(' ')
  end

  def numeric?
    Float(self) != nil rescue false
  end

  def alpha?
    !!match(/^[[:alnum:]]+$/)
  end

  def strip_control_characters
    self.chars.inject("") do |str, char|
      unless char.ascii_only? and (char.ord < 32 or char.ord == 127)
        str << char
      end
      str
    end
  end

  def strip_control_and_extended_characters
    self.chars.inject("") do |str, char|
      if char.ascii_only? and char.ord.between?(32, 126)
        str << char
      end
      str
    end
  end
end