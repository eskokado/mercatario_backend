class Credor < ApplicationRecord
  self.table_name = "credores"

  has_many :precatorios, foreign_key: "credor_id"
  has_many :documentos_pessoals, foreign_key: "credor_id"
  has_many :certidoes, foreign_key: "credor_id"
  validates :cpf_cnpj, uniqueness: true
end
