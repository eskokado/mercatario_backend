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

FactoryBot.define do
  factory :documento_pessoal do
    tipo { "rg" }
    arquivo { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.png'), 'image/png') }
    credor
  end
end
