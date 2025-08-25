class AddPortadorActualToArticulos < ActiveRecord::Migration[8.0]
  def change
    add_reference :articulos, :portador_actual, foreign_key: { to_table: :personas }, null: true
  end
end
