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

  TIPO_CERTIDAOS = %w[federal estadual municipal trabalhista]
  ORIGENS = %w[manual api]
  STATUSES = %w[negativa positiva invalida pendente]
end
