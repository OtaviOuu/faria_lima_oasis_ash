defmodule FariaLimaOasis.Vagas do
  use Ash.Domain,
    otp_app: :faria_lima_oasis,
    extensions: [AshAdmin.Domain, AshPhoenix]

  admin do
    show? true
  end

  resources do
    resource FariaLimaOasis.Vagas.Vaga do
      define :create_vaga, action: :create
      define :get_vaga, action: :read, get_by: :id
    end

    resource FariaLimaOasis.Vagas.Area do
      define :list_areas, action: :read
      define :create_area, action: :create
    end

    resource FariaLimaOasis.Vagas.VagaArea

    resource FariaLimaOasis.Vagas.Empresa do
      define :list_empresas, action: :read
      define :create_empresa, action: :create
    end
  end
end
