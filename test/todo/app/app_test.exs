defmodule Todo.AppTest do
  use Todo.DataCase

  alias Todo.App

  describe "tasks" do
    alias Todo.App.Task

    @valid_attrs %{completed: true, content: "some content"}
    @update_attrs %{completed: false, content: "some updated content"}
    @invalid_attrs %{completed: nil, content: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> App.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert App.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert App.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = App.create_task(@valid_attrs)
      assert task.completed == true
      assert task.content == "some content"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = App.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = App.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.completed == false
      assert task.content == "some updated content"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = App.update_task(task, @invalid_attrs)
      assert task == App.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = App.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> App.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = App.change_task(task)
    end
  end
end
