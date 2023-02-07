---@meta

---@class LspClient
---@field id integer
---@field name string
---@field rpc table
---@field handlers table
---@field requests table
---@field config table
---@field server_capabilities table

---@class Source
---@field name? string
---@field method? string
---@field id? integer

---@class DashboardItem
---@field type string
---@field val any
---@field opts { position?: string, shrink_margin?: boolean, keymap?: string[] | table<string, any>[] }
---@field on_press? fun()
---@field shortcut? string
---@field align_shortcut? string
---@field hl_shortcut? string
