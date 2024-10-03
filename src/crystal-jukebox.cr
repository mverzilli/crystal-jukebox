# Create a class
class Song
  # Classes can have properties.
  # This is one of the few places where
  # Crystal forces you to explicitly
  # set types!
  # Properties are accessed internally
  # by prepending @.
  # You'll see it used below.
  property title : String
  property artist : String

  # Constructors must be called "initialize"
  def initialize(@title : String, @artist : String)
    # Prefixing contructor params with @
    # is just fancier way of setting properties.
    # This is just a shorthand for:
    # @title = title
    # @artist = artist
  end

  # You can overload some operators
  def ==(other : self)
    @title == other.title && @artist == other.artist
  end
end

class Jukebox
  # We will represent our catalog
  # with an array of songs.
  # Arrays are generic types,
  # Array(Song) means: an Array of Song's
  def initialize(@songs : Array(Song))
  end

  # We're choosing to be explicit about our types,
  # But this function would work exactly the same
  # if we removed all its type annotations.
  # Crystal's type inference picks it up.
  # Try it!
  def list_by_artist(artist : String) : Array(Song)
    # @songs is an array from the standard library,
    # so it comes with a huge amount of utility methods
    # out of the box.
    # Here we take advantage of `select`, which
    # lets you filter out elements given a predicate
    # The predicate is defined by a block that is evaluated
    # on each element of the array.
    # Note that Crystal knows you can safely
    # call `artist` on song, because it knows that
    # @songs is not only an Array, but an Array that contains
    # Song's.
    # Try calling something random on `song` instead,
    # you'll see how the compiler gently rejects it.
    # If you don't come from the Ruby world, you might
    # not be familiar with the concept of a block.
    # You might have used lambda expressions in other languages.
    # This is not exactly the same, but it's similar.
    @songs.select {|song| song.artist == artist}
  end
end

def print_horizontal_ruler
  # Use puts to print a line to console
  puts "-------------------------------------------------------------------"
end

def print_welcome
  puts "Welcome to Crystal Jukebox!"
  print_horizontal_ruler
end

def print_list_by_artist(jukebox : Jukebox, artist : String)
  # You can interpolate runtime values in strings
  # by using "... #{something you eval} ..."
  puts "Listing songs by #{artist}..."

  # pp stands for "pretty print".
  # Crystal will do its best to print
  # a readable representation of the argument
  # leveraging all the information it knows about it
  pp jukebox.list_by_artist(artist)
  print_horizontal_ruler
end

# Note that code is actually executing,
# just as you would expect from a scripting language.

# Methods can be invoked passing arguments in (),
# but in most cases the () are optional.
# This sometimes gives code a more "DSL-ish" feel.
jukebox = Jukebox.new [
  Song.new("Carnival", "The Cardigans"),
  Song.new("Nos siguen pegando abajo", "Charly García"),
  Song.new("Lovefool", "The Cardigans"),
  Song.new("Step on Me", "The Cardigans"),
  Song.new("My favorite game", "The Cardigans"),
  Song.new("Demoliendo Hoteles", "Charly García"),
  Song.new("Rompela", "Charly García"),
  Song.new("No voy en tren", "Charly García"),
]

print_welcome
print_list_by_artist jukebox, "The Cardigans"
print_list_by_artist jukebox, "Charly García"

