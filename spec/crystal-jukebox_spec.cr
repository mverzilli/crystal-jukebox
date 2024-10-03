require "./spec_helper"

describe Jukebox do
  it "works" do
    jukebox = Jukebox.new [
      Song.new("FooSong", "FooArtist"),
      Song.new("BarSong 2", "BarArtist"),
      Song.new("BarSong", "BarArtist"),
      Song.new("FooSong 2", "FooArtist"),
    ]

    jukebox.list_by_artist("FooArtist").should eq([
      Song.new("FooSong", "FooArtist"),
      Song.new("FooSong 2", "FooArtist"),
    ])
  end
end
