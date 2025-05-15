class Credor < ApplicationRecord
  self.table_name = "credores"

  has_many :precatorios, foreign_key: "credor_id", inverse_of: :credor
  has_many :documentos_pessoais, foreign_key: "credor_id"
  has_many :certidoes, foreign_key: "credor_id"
  validates :cpf_cnpj, uniqueness: true

  accepts_nested_attributes_for :precatorios

  def as_json(options = {})
    super(options.merge(
      include: {
        precatorios: {
            only: [ :id, :numero_precatorio, :valor_nominal, :foro, :data_publicacao ]
        }
      }
    ))
  end
end
