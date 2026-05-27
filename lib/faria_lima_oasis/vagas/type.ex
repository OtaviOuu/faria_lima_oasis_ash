defmodule FariaLimaOasis.Vagas.Type do
  use Ash.Type.Enum, values: [:estagio, :trainee, :junior, :pleno, :senior, :summer_job]
end
