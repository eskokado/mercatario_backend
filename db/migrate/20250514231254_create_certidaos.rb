class CreateCertidaos < ActiveRecord::Migration[8.0]
  def change
    create_table :certidoes do |t|
      t.integer     :credor_id
      t.string      :tipo
      t.string      :origem
      t.string      :status
      t.string      :arquivo_url
      t.text        :conteudo_base64
      t.datetime    :recebida_em

      t.timestamps
    end

    add_foreign_key :certidoes, :credores, column: :credor_id
  end
end
