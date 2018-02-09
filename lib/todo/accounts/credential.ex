defmodule Todo.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todo.Accounts.{User, Credential}


  schema "credentials" do
    field :email, :string
    field :hashed_password, :string
    field :password, :string, virtual: true
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Credential{} = credential, attrs) do
    credential
    |> cast(attrs, [:email, :hashed_password])
    |> validate_required([:email, :hashed_password])
    |> unique_constraint(:email)
    #|> validate_format(:email, ~r/@/)
    #|> validate_length(:password, min: 5)
  end
end
