defmodule FariaLimaOasis.Vagas do
  use Ash.Domain,
    otp_app: :faria_lima_oasis,
    extensions: [AshAdmin.Domain]

  admin do
    show? true
  end

  resources do
    resource FariaLimaOasis.Vagas.Vaga
    resource FariaLimaOasis.Vagas.Area
    resource FariaLimaOasis.Vagas.VagaArea
  end
end
