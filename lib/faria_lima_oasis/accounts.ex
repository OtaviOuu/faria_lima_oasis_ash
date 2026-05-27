defmodule FariaLimaOasis.Accounts do
  use Ash.Domain, otp_app: :faria_lima_oasis, extensions: [AshAdmin.Domain]

  admin do
    show? true
  end

  resources do
    resource FariaLimaOasis.Accounts.Token
    resource FariaLimaOasis.Accounts.User
  end
end
