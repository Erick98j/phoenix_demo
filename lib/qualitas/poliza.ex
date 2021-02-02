defmodule Qualitas.Poliza do

  alias Qualitas.Poliza
  alias Qualitas.Repo

  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "polizas" do
    field :aseguradora, :string
    field :numero, :string
    field :nombre, :string
    field :vehiculo, :string
    field :estatus, :string
    field :vencimiento_de_pago, :string
    field :cantidad_de_pago, :string
    field :estatus_de_pago, :string
    field :sincronizacion, :string
    field :telefono1, :string
    field :telefono2, :string
    field :email, :string
    field :cobertura, :string
    field :periodisidad, :string
    field :vencimiento_de_poliza
    field :importe_total, :string
    field :numero_de_recibo, :string
    field :instrucciones, :string
    field :whatsapp, :string
  end

  def signup_changeset(poliza = %Qualitas.Poliza{}, params) do
    poliza
      |> cast(params, [:aseguradora, :numero, :nombre, :vehiculo, :estatus, :vencimiento_de_pago, :cantidad_de_pago, :estatus_de_pago, :sincronizacion, :telefono1, :telefono2, :email, :cobertura, :periodisidad, :vencimiento_de_poliza, :importe_total, :numero_de_recibo, :instrucciones, :whatsapp])
      |> validate_required([:aseguradora, :numero, :nombre, :vehiculo, :estatus, :vencimiento_de_pago, :cantidad_de_pago, :cantidad_de_pago, :estatus_de_pago, :sincronizacion, :telefono1, :telefono2, :email, :cobertura, :periodisidad, :vencimiento_de_poliza, :importe_total, :numero_de_recibo, :instrucciones, :whatsapp])
  end

  def save(changeset) do
    Qualitas.Repo.insert(changeset)
  end

  def get_policies do
    Poliza
    |> Repo.all
  end

  def get_policies_to_due do
    query = from p in Qualitas.Poliza,
            where: p.estatus_de_pago == "Por cobrar" or p.estatus_de_pago == "Vencido",
            select: p
    Repo.all(query)
  end

  def get_policies_finished do
    query = from p in Qualitas.Poliza,
            where: p.estatus == "Finalizada",
            select: p
    Repo.all(query)
  end

  def get_policies_cancelled do
    query = from p in Qualitas.Poliza,
            where: p.estatus == "Cancelada",
            select: p
    Repo.all(query)
  end

  def search(policy_number) do
    query = from p in Qualitas.Poliza,
            where: p.numero == ^policy_number,
            select: p
    Repo.one(query)
  end

end

# Qualitas.Poliza.signup_changeset(%Qualitas.Poliza{}, %{aseguradora: "Qualitas", numero: "12345667890", nombre: "Victor Manuel Flores Santaolalla", vehiculo: "sdasdasdasd sdasdsdasdas sdasdasdasd sdasdas", estatus: "Activa", vencimiento_de_pago: "21/01/2021", cantidad_de_pago: "18000", estatus_de_pago: "Pendiente", sincronizacion: "Hace un momento", telefono1: "5567389922", telefono2: "5677838388", email: "vict_123@gmail.com", cobertura: "Amplia", periodisidad: "Trimestral", vencimiento_de_poliza: "21/01/22", importe_total: "83000", numero_de_recibo: "5", instrucciones: "https://www.qualitas.com/fgdgdf/sds", whatsapp: "Pague plox" })
