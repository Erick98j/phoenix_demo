defmodule Qualitas.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(%Qualitas.User{} = user, params) do
    user
    |> cast(params, [:first_name, :last_name, :email, :password])
    |> validate_required([:first_name, :last_name, :email, :password])
    |> validate_format(:email, ~r/@/, message: "is invalid")
    |> validate_length(:password, min: 6, max: 20)
    |> unique_constraint(:email)
    |> put_hashed_password()
  end

  defp put_hashed_password(changeset) do
    case changeset.valid? do
      true ->
        changes = changeset.changes
        put_change(changeset, :password, hashpwsalt(changes.password))
      _ ->
        changeset
    end
  end

end
