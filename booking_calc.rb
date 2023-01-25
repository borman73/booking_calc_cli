require 'date'

WEEKDAY_COST = 1750
WEEKEND_COST = 2500

class Calculator

  attr_reader :checkin_date, :days 
 
  def initialize(checkin_date, days)
    @checkin_date = checkin_date
    @days = days
  end

  def calculate(checkin_date, days)
    checkout_date = (checkin_date + days)

    period = Array(checkin_date..checkout_date)
    period.shift

    cost = period.reduce(0) do |total, day| 
      if day.saturday? || day.sunday? 
        total + WEEKEND_COST
      else
        total + WEEKDAY_COST 
      end
    end
  end

end

puts "\n- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "
puts "\nЗдравствуйте! Давайте рассчитаем стоимость вашего пребывания в отеле."
puts "\n- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "

checkin_date = ""
days = 0

loop do
  puts "\nВведите дату заезда в формате день.месяц.год (например 08.03.2023):"
  input_date = gets.strip

  if input_date.empty? 
    puts "\n Вы ничего не ввели"
  elsif Date.strptime(input_date, "%d.%m.%Y") < Date.today
    puts "\nДата не должна быть из прошлого"
  else
    checkin_date = Date.strptime(input_date, "%d.%m.%Y")
    break  
  end
end

loop do 
  puts "\nВведите количество дней пребывания в отеле:"
  input_days = gets.strip
  
  if input_days.empty? 
    puts "\n Вы ничего не ввели" 
  elsif input_days.to_i < 1
    puts "Минимальный срок пребывания - 1 день" 
  else
    days = input_days.to_i
    break
  end
end

calc = Calculator.new(checkin_date, days)
puts "\n- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
puts "Стоимость проживания составит: #{calc.calculate(calc.checkin_date, calc.days)} руб."
puts "\n- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
