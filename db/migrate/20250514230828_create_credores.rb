class CreateCredores < ActiveRecord::Migration[8.0]
  def change
    create_table :credores do |t|
      t.string :nome
      t.string :cpf_cnpj
      t.string :email
      t.string :telefone

      t.timestamps
    end
  end
end
