class DocumentosPessoaisController < ApplicationController
  def upload
    credor = Credor.find(params[:id])
    documento = credor.documentos_pessoais.new(tipo: params[:tipo])
    documento.arquivo.attach(params[:arquivo])
    if documento.save
      head :ok
    else
      render json: documento.errors, status: :unprocessable_entity
    end
  end
end
