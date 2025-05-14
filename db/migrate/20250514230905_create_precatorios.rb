class CreatePrecatorios < ActiveRecord::Migration[8.0]
  def change
    create_table :precatorios do |t|
      t.integer :credor_id
      t.string :numero_precatorio
      t.decimal :valor_nominal
      t.string :foro
      t.date :data_publicacao

      t.timestamps
    end

    add_foreign_key :precatorios, :credores, column: :credor_id
  end
end
