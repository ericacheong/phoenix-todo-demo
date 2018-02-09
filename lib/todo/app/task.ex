defmodule Todo.App.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todo.App.Task
  alias Todo.Accounts.User


  schema "tasks" do
    field :completed, :boolean, default: false
    field :content, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:content, :completed])
    |> validate_required([:content, :completed])
  end
end
