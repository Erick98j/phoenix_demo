defmodule Qualitas.Repo.Migrations.CreatePoliza do
  use Ecto.Migration

  def change do
    create table(:polizas) do
      add :aseguradora, :string
      add :numero, :string
      add :nombre, :string
      add :vehiculo, :string
      add :estatus, :string
      add :vencimiento_de_pago, :string
      add :cantidad_de_pago, :string
      add :estatus_de_pago, :string
      add :sincronizacion, :string
      add :telefono1, :string
      add :telefono2, :string
      add :email, :string
      add :cobertura, :string
      add :periodisidad, :string
      add :vencimiento_de_poliza, :string
      add :importe_total, :string
      add :numero_de_recibo, :string
      add :instrucciones, :string
      add :whatsapp, :string
    end
  end
end
