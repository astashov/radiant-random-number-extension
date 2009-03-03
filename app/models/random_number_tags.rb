module RandomNumberTags
  include Radiant::Taggable

  desc %{
    Generates random number in given range. Range is specified by attributes @min@ and @max@.

    *Usage:*

    <pre><code><r:random_number min='10' max='20' /></code></pre>
  }
  tag 'random_number' do |tag|
    min = tag.attr['min'].to_i
    max = tag.attr['max'].to_i
    
    if max > min
      random_number = rand(max - min)
      random_number += min
    else
      logger.warn(
        "\033[1;31mCan't generate random number in range: min = '#{tag.attr['min']}', max = '#{tag.attr['max']}'\033[0m"
      )
      '0'
    end
  end
  
end