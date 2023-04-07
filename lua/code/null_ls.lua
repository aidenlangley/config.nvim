return {
  {
    config = function()
      local tools = {
        "black",
        "flake8",
        "isort",
        "prettierd",
        "selene",
        "shellcheck",
        "shfmt",
        "stylua",
      }

      local registry = require("mason-registry")
      for _, tool in ipairs(tools) do
        local pkg = registry.get_package(tool)
        if not pkg:is_installed() then
          pkg:install()
        end
      end
    end,
  },
}
