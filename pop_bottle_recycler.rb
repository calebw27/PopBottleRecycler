$Bottle_of_Pop_Cost = 20
$Empty_Bottle_Return_Value = 10
$Bottle_Cap_Return_Value = 5
$Terminated = false
$Entered = false


until $Terminated
  @total_empty_return_cash = 0
  @total_empty_return_bottle_purchase = 0
  @total_caps_return_cash = 0
  @total_caps_return_bottle_purchase = 0
  @total_of_pop_bottles_bought = 0
  @left_over = 0


  def buy_pop(investment_amount)
    units = (investment_amount / $Bottle_of_Pop_Cost)
  end

  def sell_caps(number_of_units)
    cashback = number_of_units * $Bottle_Cap_Return_Value
  end

  def sell_empties(number_of_units)
    cashback = number_of_units * $Empty_Bottle_Return_Value
  end

  def user_input
    user_investment_input = nil
    until $Entered
      until user_investment_input.is_a?(Fixnum) do
        print "\nPlease enter the amount of investment that you'd like to make: "
        begin
          user_investment_input = Integer(gets) * 10
        rescue ArgumentError # calling Integer with a string argument raises this
          print "\nThat is not a valid number!"
          user_investment_input = nil # explicitly reset input so the loop is re-entered
        end
      end
      $Entered = true
    end
    user_investment_input
  end



  def check(input)

    initial_value = input
    full_bottles = buy_pop(input)
    @total_of_pop_bottles_bought += full_bottles
    print "\nFor $#{input/10} you can get #{full_bottles} bottles of pop.\n"
    i = 0

      until full_bottles.zero?
        i += 1
        print "\nPass #{i}\n"

        sold_empties_cash = sell_empties(full_bottles)
        if sold_empties_cash >= $Bottle_of_Pop_Cost
        @total_empty_return_cash += sold_empties_cash
        new_bottles_from_empties = buy_pop(sold_empties_cash)
        @total_empty_return_bottle_purchase += new_bottles_from_empties
        print "#{full_bottles} bottles of pop will generate $#{sold_empties_cash/10} from the return of empties for which we can buy #{new_bottles_from_empties} new bottles of pop.\n"
        else
          @left_over += (sold_empties_cash)
          print "The empty bottle return generated only $#{sold_empties_cash/10} which is not enough to buy more bottles of pop.\n"
          new_bottles_from_empties = 0
        end

        sold_caps_cash = sell_caps(full_bottles)
        if sold_caps_cash >= $Bottle_of_Pop_Cost
        @total_caps_return_cash += sold_caps_cash
        new_bottles_from_caps = buy_pop(sold_caps_cash)
        @total_caps_return_bottle_purchase += new_bottles_from_caps
        print "#{full_bottles} Bottles of Pop will generate $#{sold_caps_cash/10} from the return of caps for which we can buy #{new_bottles_from_caps} new Bottles of Pop.\n"
        else
          @left_over += (sold_caps_cash)
          print "The bottle caps return generated only $#{sold_caps_cash/10} which is not enough to buy more bottles of pop.\n"
          new_bottles_from_caps = 0
        end

        full_bottles = new_bottles_from_empties + new_bottles_from_caps
        @total_of_pop_bottles_bought += full_bottles


            while @left_over >= $Bottle_of_Pop_Cost
          print "\nIt seems that you just scraped enough of funds for another bottle of pop!\n"
          @left_over -= $Bottle_of_Pop_Cost
          full_bottles += 1
          @total_of_pop_bottles_bought += full_bottles
        end




      end
    print "\n\nTotals"
    print "\nYour initial investment of $#{initial_value/10} to buy #{buy_pop(initial_value)} bottles of pop has generated the following: \n"
    print "\n$#{@total_empty_return_cash/10} in total from the return of empty bottles, allowing to buy a total of #{@total_empty_return_bottle_purchase} more bottles of pop. \n"
    print "$#{@total_caps_return_cash/10} in total from the return of bottles caps, allowing to buy a total of #{@total_caps_return_bottle_purchase} more bottles of pop. \n"
    print "Furthermore you have purchased a total of #{@total_of_pop_bottles_bought} bottles of pop and have $#{@left_over/10} leftover.\n\n"
  end

  check(user_input)


  $Terminated = true

end

