local configs = require "nvchad.configs.lspconfig"

local on_attach = function(client, bufnr)
  configs.on_attach(client, bufnr)

  -- Автоформатирование при сохранении
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
end

local capabilities = configs.capabilities
local lspconfig = require "lspconfig"

-- Серверы, которые нужно запустить
local servers = { "html", "cssls", "tsserver", "clangd", "gopls", "gradle_ls" }

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    commands = {
      OrganizeImports = {
        organize_imports,
        description = "Organize Imports",
      },
    },
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  }
end

-- Дополнительные настройки для prismals и volar
lspconfig.prismals.setup {}
lspconfig.volar.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  init_options = {
    vue = {
      hybridMode = false,
    },
  },
}
