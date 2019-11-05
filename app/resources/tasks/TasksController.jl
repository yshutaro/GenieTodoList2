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
  id = @params(:task_id)
  task = SearchLight.findoneby(Tasks.Task , SQLWhereExpression("id = ?", id))
  html(:tasks, :edit, task = task)
end

function update()
  done = false
  try
    if @params(:task_done) == "1"
      done = true
    else
      done = false
    end
  catch e
      done = false
  end
  Tasks.Task(id = @params(:task_id), content = @params(:task_content), done = done) |> save && redirect(:get_tasks)
end

end
