# == Schema Information
#
# Table name: certidoes
#
#  id              :integer          not null, primary key
#  credor_id       :integer
#  tipo            :string
#  origem          :string
#  status          :string
#  arquivo_url     :string
#  conteudo_base64 :text
#  recebida_em     :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Certidao < ApplicationRecord
  self.table_name = "certidoes"

  belongs_to :credor, foreign_key: "credor_id"
  has_one_attached :arquivo

  TIPOS_CERTIDOES = %w[federal estadual municipal trabalhista]
  ORIGENS = %w[manual api]
  STATUSES = %w[negativa positiva invalida pendente]

  validates :tipo, presence: true, inclusion: { in: TIPOS_CERTIDOES }
  validates :origem, presence: true, inclusion: { in: ORIGENS }
  validates :status, presence: true, inclusion: { in: STATUSES }

  validate :arquivo_deve_ser_pdf

  private

  def arquivo_deve_ser_pdf
    return unless arquivo.attached?
    errors.add(:arquivo, "deve ser um PDF") unless arquivo.content_type == "application/pdf"
  end
end
