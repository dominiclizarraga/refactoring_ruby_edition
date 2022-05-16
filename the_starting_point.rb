# this is the first glance the book gives you of what refactoring really means

# first example


class Movie

  REGULAR = 0
  NEW_RELEASE = 1
  CHILDREN = 2

  attr_reader :title
  attr_accessor :price_code

  def initialize(title, price_code)
    @title, @price_code = title, price_code
  end

end

class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie = movie
    @days_rented = days_rented
  end

end

class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

end


def statement
  total_amount, frequent_renter_points = 0, 0
  result = "Rental Record for #{@name}\n"
  @rentals.each do |element|
    this_amount = element.charge

    # add frequent renter points

    frequent_renter_points += 1

    # add bonus for a two day new release rental

    if element.movie.price_code == Movie::NEW_RELEASE && element.days_rented > 1
      frequent_renter_points += 1
    end

    # show figures for this rental

    result += "\t" + element.movie.title + "\t" + element.charge.to_s + "\n"
    total_amount += element.charge

  # add footer line

  result += "Amount owed is #{total_amount}\n"
  result += "You earned #{frequent_renter_points} frequent renter points"
  result
  end

  def amount_for(rental)
    rental.charge
  end

end


class Rental
  # determine amount for each line

  def charge
    result = 0
    case movie.price_code
    when Movie::REGULAR
      result += 2
      result += (days_rented - 2) * 1.5 if days_rented > 2
    when Movie::NEW_RELEASE
      result += days_rented * 3
    when Movie::CHILDREN
      result += 1.5
      result += (days_rented - 3) * 1.5 if days_rented > 2
    end
  end

end
