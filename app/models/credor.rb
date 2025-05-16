# == Schema Information
#
# Table name: credores
#
#  id         :integer          not null, primary key
#  nome       :string
#  cpf_cnpj   :string
#  email      :string
#  telefone   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Credor < ApplicationRecord
  self.table_name = "credores"

  has_many :precatorios, foreign_key: "credor_id", inverse_of: :credor
  has_many :documentos_pessoais, foreign_key: "credor_id"
  has_many :certidoes, foreign_key: "credor_id"

  validates :nome, presence: true
  validates :cpf_cnpj, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :telefone, presence: true

  accepts_nested_attributes_for :precatorios

  def as_json(options = {})
    super(options.merge(
      include: {
        precatorios: {
            only: [ :id, :numero_precatorio, :valor_nominal, :foro, :data_publicacao ]
        },
        documentos_pessoais: {
            only: [ :id, :tipo, :arquivo_url, :enviado_em ]
        },
        certidoes: {
            only: [ :id, :tipo, :origem, :status, :arquivo_url, :recebida_em ]
        }
      }
    ))
  end
end
