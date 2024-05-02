return {
  -- Required fields
  name = 'cockpit-widgets',
  builder = function(_)
    -- This must return an overseer.TaskDefinition
    return {
      -- cmd is the only required field
      cmd = { 'pnpm' },
      -- additional arguments for the cmd
      args = { 'dev' },
      -- the name of the task (defaults to the cmd of the task)
      name = 'pnpm dev',
      -- set the working directory for the task
      cwd = '/home/brunnseb/Development/SUISA/cockpit/libs/cockpit-widgets/',
      -- additional environment variables
      -- the list of components or component aliases to add to the task
      -- components = { 'my_custom_component', 'default' },
    }
  end,
  -- Optional fields
  desc = 'Run dev server for cockpit-widgets',
  -- Tags can be used in overseer.run_template()
  -- tags = { overseer.TAG.BUILD },
  params = {
    -- See :help overseer-params
  },
  -- Determines sort order when choosing tasks. Lower comes first.
  priority = 50,
  -- Add requirements for this template. If they are not met, the template will not be visible.
  -- All fields are optional.
  condition = {
    dir = '/home/brunnseb/Development/SUISA/cockpit/',
  },
}
