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

FactoryBot.define do
  factory :credor do
    nome { "João Silva" }
    sequence(:cpf_cnpj) { |n| "123.456.789-#{n.to_s.rjust(2, '0')}" }
    email { "joao@example.com" }
    telefone { "(11) 99999-9999" }

    trait :with_associations do
      after(:create) do |credor|
        create_list(:precatorio, 2, credor: credor)
        create_list(:documento_pessoal, 3, credor: credor)
        create_list(:certidao, 1, credor: credor)
      end
    end
  end
end
