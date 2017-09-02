class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string   :kyouin
      t.string   :kamoku
      t.string   :jigen
      t.integer  :year
      t.string   :kaikou
      t.timestamps
    end
  end
end
