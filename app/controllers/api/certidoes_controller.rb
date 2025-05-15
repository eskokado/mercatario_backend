class Api::CertidoesController < ApplicationController
  def consultar
    certidoes = [
      { tipo: "federal", status: "negativa", conteudo_base64: "..." },
      { tipo: "trabalhista", status: "positiva", conteudo_base64: "..." }
    ]
    render json: { cpf_cnpj: params[:cpf_cnpj], certidoes: certidoes }
  end
end
