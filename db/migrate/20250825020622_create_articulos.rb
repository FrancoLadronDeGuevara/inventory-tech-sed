class CreateArticulos < ActiveRecord::Migration[8.0]
  def change
    create_table :articulos do |t|
      t.string :modelo, null: false
      t.string :marca, null: false
      t.date :fecha_ingreso, null: false
      t.references :portador_actual, null: true, foreign_key: { to_table: :personas }

      t.timestamps
    end
  end
end
