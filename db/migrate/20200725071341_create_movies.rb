class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :content
      t.integer :rank
      t.string :title
      t.date :release_date

      t.timestamps
    end
  end
end
