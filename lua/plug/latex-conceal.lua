return {
	enabled = false,
  "pxwg/latex-conceal.nvim",
  event = "VeryLazy",
  build = "make",
  --- @type LaTeXConcealOptions
  opts = {
    enabled = true,
    conceal = {
      "greek",
      "script",
      "math",
      "font",
      "delim",
    },
    ft = { "tex", "latex",  },
  },
}
