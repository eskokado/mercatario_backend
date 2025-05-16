# == Schema Information
#
# Table name: documentos_pessoais
#
#  id          :integer          not null, primary key
#  credor_id   :integer
#  tipo        :string
#  arquivo_url :string
#  enviado_em  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class DocumentoPessoal < ApplicationRecord
  self.table_name = "documentos_pessoais"

  belongs_to :credor, foreign_key: "credor_id"
  has_one_attached :arquivo
  validates :tipo, presence: true

  TIPO_DOCS = %w[rg, cnh, comprovante_residencia, cpf, certidao_nascimento, certidao_casamento, passaporte, outro]
end
