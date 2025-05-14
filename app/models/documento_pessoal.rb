class DocumentoPessoal < ApplicationRecord
  belongs_to :credor
  has_one_attached :arquivo
  validates :tipo, presence: true

  TIPO_DOCS = %w[rg, cnh, comprovante_residencia, cpf, certidao_nascimento, certidao_casamento, passaporte, outro]
end
