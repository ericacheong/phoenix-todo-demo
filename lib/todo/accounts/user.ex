defmodule Todo.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todo.Accounts.{User, Credential}
  alias Todo.App.Task


  schema "users" do
    field :name, :string
    field :username, :string
    has_one :credential, Credential
    has_many :task, Task

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> unique_constraint(:username)
  end
end
