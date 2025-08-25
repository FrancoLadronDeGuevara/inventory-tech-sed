class CreatePersonas < ActiveRecord::Migration[8.0]
  def change
    create_table :personas do |t|
      t.string :nombre, null: false
      t.string :apellido, null: false

      t.timestamps
    end
  end
end
