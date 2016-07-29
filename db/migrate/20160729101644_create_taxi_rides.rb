class CreateTaxiRides < ActiveRecord::Migration[5.0]
  def change
    create_table :taxi_rides do |t|
      t.date        :ride_date
      t.references  :taxi_provider, :null => false
      t.string      :origin, :limit => 1024, :null => false
      t.string      :destination, :limit => 1024, :null => false
      t.integer     :price_in_cents, :null => false
      t.integer     :distance_in_meters, :null => false
      t.timestamps
    end
    add_foreign_key :taxi_rides, :taxi_providers
  end
end
