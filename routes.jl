using Genie.Router
using TasksController # 追加

route("/") do
  serve_static_file("welcome.html")
end

# 追加（タスク表示）
route("/tasks", TasksController.index)
route("/tasks", TasksController.index, named = :get_tasks) # namedを追加

# 追加
route("/tasks/new", TasksController.new, named = :new_task) # namedを追加
route("/tasks/create", TasksController.create, method = POST, named = :create_task)

route("/tasks/edit", TasksController.edit, method = GET, named = :edit_task)
route("/task/update", TasksController.update, method = POST, named = :update_task)
