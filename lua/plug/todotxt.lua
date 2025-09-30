return {
  enabled = false,
  'arnarg/todotxt.nvim',
  lazy = false,
  config = function()
    require('todotxt-nvim').setup({
      todo_file = "~/projects/syncthing/markor/todo.txt",
    })
  end
}
