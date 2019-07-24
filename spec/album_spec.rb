require('rspec')
require('album')
require('pry')

describe '#Album' do
  before(:each) do
    Album.clear()
  end
  describe('.all') do
    it("returns an empty array when there are no albums") do
      expect(Album.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an album") do
      album = Album.new("Giant Steps", nil, "Artist", "Year", "Genre") # nil added as second argument
      album.save()
      album2 = Album.new("Blue", nil, "Artist", "Year", "Genre") # nil added as second argument
      album2.save()
      expect(Album.all).to(eq([album, album2]))
    end
  end

  describe('#==') do
    it("is the same album if it has the same attributes as another album") do
      album = Album.new("Blue", nil, "Artist", "Year", "Genre")
      album2 = Album.new("Blue", nil, "Artist", "Year", "Genre")
      expect(album).to(eq(album2))
    end
  end

  describe('.clear') do
    it("clears all albums") do
      album = Album.new("Giant Steps", nil, "Artist", "Year", "Genre")
      album.save()
      album2 = Album.new("Blue", nil, "Artist", "Year", "Genre")
      album2.save()
      Album.clear()
      expect(Album.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an album by id") do
      album = Album.new("Giant Steps", nil, "Artist", "Year", "Genre")
      album.save()
      album2 = Album.new("Blue", nil, "Artist", "Year", "Genre")
      album2.save()
      expect(Album.find(album.id)).to(eq(album))
    end
  end

  describe('#update') do
    it("updates an album by id") do
      album = Album.new("Giant Steps", "John Coltrane", 1960, "Jazz", nil)
      album.save()
      album.update("A Love Supreme")
      expect(album.name).to(eq("A Love Supreme"))
    end
  end

  describe('#delete') do
   it("deletes an album by id") do
     album = Album.new("Giant Steps", "John Coltrane", 1960, "Jazz", nil)
     album.save()
     album2 = Album.new("Blue", nil, "Artist", "Year", "Genre")
     album2.save()
     album.delete()
     expect(Album.all).to(eq([album2]))
   end
 end

  describe('.search') do
    it('finds an album by name')do
    album = Album.new("De Stijl", nil, "Artist", "Year", "Genre")
    album.save()
    album2 = Album.new("Demon Days", nil, "Artist", "Year", "Genre")
    album2.save()
    search = Album.search("Demon Days")
    expect(search).to(eq(album2))
    end
  end

  describe('.sort') do
    it('sorts an album by name')do
    album = Album.new("Apples", nil, "Artist", "Year", "Genre")
    album.save()
    album2 = Album.new("Entroducing", nil, "Artist", "Year", "Genre")
    album2.save()
    album3 = Album.new("Currents", nil, "Artist", "Year", "Genre")
    album3.save()
    example = Album.sort()
    expect(example).to(eq([[1, album], [3, album3], [2, album2]]))
    end
  end

  describe('#sold') do
    it('moves an album to sold_albums hash')do
    album = Album.new("Afterburner", nil, "Artist", "Year", "Genre")
    album.save()
    album2 = Album.new("Yours, Conditionally", nil, "Artist", "Year", "Genre")
    album2.save()
    album.sell()
    expect(album).to(eq(Album.sold[0]))
    expect(Album.all).to(eq([album2]))
    end
  end
end
