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
    end

    resource FariaLimaOasis.Vagas.Area do
      define :list_areas, action: :read
    end

    resource FariaLimaOasis.Vagas.VagaArea
  end
end
