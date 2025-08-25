class CreateTransferencias < ActiveRecord::Migration[8.0]
  def change
    create_table :transferencias do |t|
      t.references :articulo, null: false, foreign_key: true
      t.references :portador_anterior, null: true, foreign_key: { to_table: :personas }
      t.references :portador_nuevo, null: false, foreign_key: { to_table: :personas }
      t.datetime :fecha_transferencia

      t.timestamps
    end
  end
end
