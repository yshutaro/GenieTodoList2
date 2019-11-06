module TasksController

using Genie.Renderer
using SearchLight
using Tasks
using Genie.Router
using Genie.Requests

struct Task
  id::Int
  content::String
  done::Bool
end

function index()
  html(:tasks, :tasks, tasks = SearchLight.all(Tasks.Task))
end

function new()
  html(:tasks, :new)
end

function create()
  Tasks.Task(content = @params(:task_content), done = false) |> save && redirect(:get_tasks)
end

function edit()
  id = payload(:id)
  task = SearchLight.findoneby(Tasks.Task , SQLWhereExpression("id = ?", id))
  html(:tasks, :edit, task = task)
end

function update()
  id = payload(:id)
  done = false
  try
    @params(:task_done)
    done = true
  catch
    done = false
  end
  Tasks.Task(id = id, content = @params(:task_content), done = done) |> save && redirect(:get_tasks)
end

end
