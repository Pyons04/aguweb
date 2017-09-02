class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :unit_id
      t.integer :user_id
      t.integer :gpa
      t.text    :content
      t.text    :test
      t.integer :satisfaction
      t.timestamps
    end
  end
end
