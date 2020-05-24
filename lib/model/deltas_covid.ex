defmodule DeltasCovid do
  defstruct ativos: %{porcentagem: Integer, absoluto: Integer},
            confirmados: %{porcentagem: Integer, absoluto: Integer},
            recuperados: %{porcentagem: Integer, absoluto: Integer},
            óbitos: %{porcentagem: Integer, absoluto: Integer}
end
