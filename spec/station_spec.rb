require 'station'

describe Station do
  context "Station name and zoning" do
    it "Spawns a new station, takes name and zone number; we can retrieve station name" do
      station = Station.new("Station_name", "1")
      expect(station.station_name).to eq("Station_name")
    end
    it "Spawns a new station, takes name and zone number; we can retriece zone" do
      station = Station.new("Station_name", "1")
      expect(station.zone).to eq("1")  
    end
  end
end
