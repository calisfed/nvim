--  use `log` module provided by `plenery.nvim`, it writes logs to `~/.cache/nvim/<your_plugin_name>.log`, and you can open the log file, with some vim tricks:
-- ```vim
-- autocmd BufEnter *.log checktime
-- ```
-- So every time you cursor move into that log buffer, new log written get updated in your vim buffer, that's what I did when I was developing this simple plugin. You can add more commands to archive things like automatically move cursor to the last line of buffer, too.
