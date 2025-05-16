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

FactoryBot.define do
  factory :certidao do
    tipo { "federal" }
    origem { "manual" }
    status { "pendente" }
    credor
  end
end
