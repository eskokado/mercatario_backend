class CredoresController < ApplicationController
  def create
    credor = Credor.new(credor_params)
    if credor.save
      render json: credor, status: :created
    else
      render json: credor.errors, status: :unprocessable_entity
    end
  end

  def show
    credor = Credor.includes(:precatorios, :documento_pessoals, :certidaos).find(params[:id])
    render json: credor
  end

  private

  def credor_params
    params.permit(:nome, :cpf_cnpj, :email, :telefone, precatorio_attributes: [ :numero_precatorio, :valor_nominal, :foro, :data_publicacao ])
  end
end
