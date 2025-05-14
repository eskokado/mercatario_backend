class CreateDocumentoPessoals < ActiveRecord::Migration[8.0]
  def change
    create_table :documentos_pessoais do |t|
      t.integer :credor_id
      t.string :tipo
      t.string :arquivo_url
      t.datetime :enviado_em

      t.timestamps
    end

    add_foreign_key :documentos_pessoais, :credores, column: :credor_id
  end
end
