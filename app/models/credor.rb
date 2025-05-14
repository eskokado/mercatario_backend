class Credor < ApplicationRecord
  has_many :precatorios
  has_many :documento_pessoals
  has_many :certidaos
  validates :cpf_cnpj, uniqueness: true
end
