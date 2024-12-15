local util = require("lazyvim.util")

local function format(component, text, hl_group)
  if not hl_group then
    return text
  end

  ---@type table<string, string>
  component.hl_cache = component.hl_cache or {}
  local lualine_hl_group = component.hl_cache[hl_group]
  if not lualine_hl_group then
    local utils = require("lualine.utils.utils")
    local mygui = function()
      local mybold = utils.extract_highlight_colors(hl_group, "bold") and "bold"
      local myitalic = utils.extract_highlight_colors(hl_group, "italic") and "italic"
      if mybold and myitalic then
        return mybold .. "," .. myitalic
      elseif mybold then
        return mybold
      elseif myitalic then
        return myitalic
      else
        return ""
      end
    end

    lualine_hl_group = component:create_hl({
      fg = utils.extract_highlight_colors(hl_group, "fg"),
      gui = mygui(),
    }, "LV_" .. hl_group)
    component.hl_cache[hl_group] = lualine_hl_group
  end
  return component:format_hl(lualine_hl_group) .. text .. component:get_default_hl()
end

local function pretty_path(opts)
  opts = vim.tbl_extend("force", {
    relative = "cwd",
    modified_hl = "MatchParen",
    filename_hl = "Bold",
    dirpath_hl = "Conceal",
  }, opts or {})

  return function(self)
    local path = vim.fn.expand("%:p") --[[@as string]]
    if path == "" then
      return ""
    end

    local root = util.root.get({ normalize = true })
    local cwd = util.root.cwd()

    if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
      path = path:sub(#cwd + 2)
    else
      path = path:sub(#root + 2)
    end

    local sep = package.config:sub(1, 1)
    local parts = vim.split(path, "[\\/]")

    if #parts > 3 then
      parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
    end

    if opts.modified_hl and vim.bo.modified then
      parts[#parts] = format(self, parts[#parts], opts.modified_hl)
    else
      parts[#parts] = format(self, parts[#parts], opts.filename_hl)
    end

    local dirpath = ""
    if #parts > 1 then
      dirpath = table.concat({ unpack(parts, 1, #parts - 1) }, sep)
      dirpath = format(self, dirpath .. sep, opts.dirpath_hl)
    end
    return dirpath .. parts[#parts]
  end
end

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      }
      opts.sections.lualine_a = {
        {
          function()
            return ""
          end,
          padding = { left = 1, right = 0 },
          separator = "",
        },
        "mode",
      }
      opts.sections.lualine_c[4] = { "filename" }
      opts.sections.lualine_y = { "progress" }
      opts.sections.lualine_z = {
        { "location", separator = "" },
        {
          function()
            return ""
          end,
          padding = { left = 0, right = 1 },
        },
      }
      return opts
    end,
  },
}

-- return {
--   "nvim-lualine/lualine.nvim",
--   event = "VeryLazy",
--   dependencies = { "echasnovski/mini.icons" },
--   opts = function()
--     local utils = require("tluan.core.utils")
--     local copilot_colors = {
--       [""] = utils.get_hlgroup("Comment"),
--       ["Normal"] = utils.get_hlgroup("Comment"),
--       ["Warning"] = utils.get_hlgroup("DiagnosticError"),
--       ["InProgress"] = utils.get_hlgroup("DiagnosticWarn"),
--     }
--
--     local filetype_map = {
--       lazy = { name = "lazy.nvim", icon = "💤" },
--       minifiles = { name = "minifiles", icon = "🗂️ " },
--       toggleterm = { name = "terminal", icon = "🐚" },
--       mason = { name = "mason", icon = "🔨" },
--       TelescopePrompt = { name = "telescope", icon = "🔍" },
--       ["copilot-chat"] = { name = "copilot", icon = "🤖" },
--     }
--
--     return {
--       options = {
--         component_separators = { left = " ", right = " " },
--         section_separators = { left = " ", right = " " },
--         theme = "auto",
--         globalstatus = true,
--         disabled_filetypes = { statusline = { "dashboard", "alpha" } },
--       },
--       sections = {
--         lualine_a = {
--           {
--             "mode",
--             icon = "",
--             fmt = function(mode)
--               return mode:lower()
--             end,
--           },
--         },
--         lualine_b = { { "branch", icon = "" } },
--         lualine_c = {
--           {
--             "diagnostics",
--             symbols = {
--               error = " ",
--               warn = " ",
--               info = " ",
--               hint = "󰝶 ",
--             },
--           },
--           {
--             function()
--               local devicons = require("nvim-web-devicons")
--               local ft = vim.bo.filetype
--               local icon
--               if filetype_map[ft] then
--                 return " " .. filetype_map[ft].icon
--               end
--               if icon == nil then
--                 icon = devicons.get_icon(vim.fn.expand("%:t"))
--               end
--               if icon == nil then
--                 icon = devicons.get_icon_by_filetype(ft)
--               end
--               if icon == nil then
--                 icon = " 󰈤"
--               end
--
--               return icon .. " "
--             end,
--             color = function()
--               local _, hl = require("nvim-web-devicons").get_icon(vim.fn.expand("%:t"))
--               if hl then
--                 return hl
--               end
--               return utils.get_hlgroup("Normal")
--             end,
--             separator = "",
--             padding = { left = 0, right = 0 },
--           },
--           {
--             "filename",
--             padding = { left = 0, right = 0 },
--             fmt = function(name)
--               if filetype_map[vim.bo.filetype] then
--                 return filetype_map[vim.bo.filetype].name
--               else
--                 return name
--               end
--             end,
--           },
--           {
--             function()
--               local buffer_count = require("core.utils").get_buffer_count()
--
--               return "+" .. buffer_count - 1 .. " "
--             end,
--             cond = function()
--               return require("tluan.core.utils").get_buffer_count() > 1
--             end,
--             color = utils.get_hlgroup("Operator", nil),
--             padding = { left = 0, right = 1 },
--           },
--           {
--             function()
--               local tab_count = vim.fn.tabpagenr("$")
--               if tab_count > 1 then
--                 return vim.fn.tabpagenr() .. " of " .. tab_count
--               end
--             end,
--             cond = function()
--               return vim.fn.tabpagenr("$") > 1
--             end,
--             icon = "󰓩",
--             color = utils.get_hlgroup("Special", nil),
--           },
--           {
--             function()
--               return require("nvim-navic").get_location()
--             end,
--             cond = function()
--               return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
--             end,
--             color = utils.get_hlgroup("Comment", nil),
--           },
--         },
--         lualine_x = {
--           {
--             require("lazy.status").updates,
--             cond = require("lazy.status").has_updates,
--             color = utils.get_hlgroup("String"),
--           },
--           {
--             function()
--               local icon = " "
--               local status = require("copilot.api").status.data
--               return icon .. (status.message or "")
--             end,
--             cond = function()
--               local ok, clients = pcall(vim.lsp.get_clients, { name = "copilot", bufnr = 0 })
--               return ok and #clients > 0
--             end,
--             color = function()
--               if not package.loaded["copilot"] then
--                 return
--               end
--               local status = require("copilot.api").status.data
--               return copilot_colors[status.status] or copilot_colors[""]
--             end,
--           },
--           { "diff" },
--         },
--         lualine_y = {
--           {
--             "progress",
--           },
--           {
--             "location",
--             color = utils.get_hlgroup("Boolean"),
--           },
--         },
--         lualine_z = {
--           {
--             "datetime",
--             style = "  %X",
--           },
--         },
--       },
--     }
--   end,
-- }
