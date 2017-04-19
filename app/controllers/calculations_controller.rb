class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @word_count = @text.split.size

    @character_count_with_spaces = @text.length


    @character_count_without_spaces = @text.gsub(" ","").gsub("\n","").gsub("\r","").gsub("\t","").length
    #@counter==0
    #  @textArray=@text.split
    #  for i in 0..@word_count
    #    if @textArray[i]==@special_word
    #        @counter++
    #    end
    #  end
    #@occurrences = @counter
    def count_em(string, substring)
      string.scan(/(?=#{substring})/).count
    end

    @occurrences = count_em(@text.downcase,@special_word.downcase)
    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    def payment(rate, bal, term)
      # Convert annual rate to monthly and make it decimal.
      r = rate / 1200

      # Numerator
      n = r * bal

      # Denominator
      d = 1 - (1 + r)**-term

      # Calc the monthly payment.
      pmt = n / d
    end


    @monthly_payment = payment(@apr, @principal, @years*12)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum-@minimum

    def median(array)                          #Define your method accepting an array as an argument.
      array = array.sort                     #sort the array from least to greatest
      if array.length.odd?                   #is the length of the array odd?
        return array[(array.length - 1) / 2] #find value at this index
      else array.length.even?                #is the length of the array even?
        return ( array[array.length/2] + array[array.length/2 - 1] )/2.to_f
        #average the values found at these two indexes and convert to float
      end
    end
    @median = median(@numbers)

    @sum = @numbers.sum

    @mean = @sum / @count
    def mean(array)
      array.inject(0) { |sum, x| sum += x } / array.size.to_f
    end
    def standard_deviation(array)
      m = mean(array)
      variance = array.inject(0) { |variance, x| variance += (x - m) ** 2 }
      return Math.sqrt(variance/(array.size))
    end

    @variance = (standard_deviation(@numbers) * standard_deviation(@numbers))

    @standard_deviation = standard_deviation(@numbers)

    def mode(array)

      count = []  # Number of times element is repeated in array
      output = []
      array.compact!
      unique = array.uniq
      j=0

      unique.each do |i|
        count[j] = array.count(i)
        j+=1
      end
      k=0
      count.each do |i|
        output[k] = unique[k] if i == count.max
        k+=1
      end

      return output.compact.inspect
    end
    @mode = mode(@numbers)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
