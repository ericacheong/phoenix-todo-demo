defmodule TodoWeb.App.TaskController do
  use TodoWeb, :controller

  plug :check_task_ownership when action in [:show, :edit, :update, :delete]
 
  alias Todo.App
  alias Todo.App.Task

  def index(conn, _params) do
    user = conn.assigns.current_user
    tasks = App.list_tasks(user)
    render(conn, "index.html", tasks: tasks, user: user)
  end

  def new(conn, _params) do
    changeset = App.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    user = conn.assigns.current_user
    case App.create_task(user, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: app_task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _params) do
    #task = App.get_task!(conn.assigns.task)
    task = conn.assigns.task
    render(conn, "show.html", task: task)
  end

  def edit(conn, _params) do
    task = conn.assigns.task
    changeset = App.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"task" => task_params}) do
    task = conn.assigns.task

    case App.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: app_task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, _delete) do
    task = conn.assigns.task
    {:ok, _task} = App.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: app_task_path(conn, :index))
  end

  defp check_task_ownership(conn, _) do
    task = App.get_task!(conn.params["id"])

    if task != nil && conn.assigns.current_user.id == task.user_id do
      assign(conn, :task, task)
    else
      conn
      |> put_flash(:danger, "Action not permitted")
      |> redirect(to: app_task_path(conn, :index))
      |> halt()
    end
   
  end
  
end
