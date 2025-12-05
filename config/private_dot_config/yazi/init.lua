-- You can configure your bookmarks by lua language
local bookmarks = {}

local path_sep = package.config:sub(1, 1)
local home_path = os.getenv("HOME")
table.insert(bookmarks, {
  tag = "Config",
  path = home_path .. path_sep .. ".config/",
  key = "c"
})
table.insert(bookmarks, {
  tag = "Downloads",
  path = home_path .. path_sep .. "Downloads/",
  key = "d"
})
table.insert(bookmarks, {
  tag = "GitHub",
  path = home_path .. path_sep .. "Git/github.com/aohoyd/",
  key = "g"
})
table.insert(bookmarks, {
  tag = "Home",
  path = home_path .. path_sep,
  key = "h"
})
table.insert(bookmarks, {
  tag = "PTCS GitLab",
  path = home_path .. path_sep .. "Git/gitlab.ptsecurity.com/ptcs/",
  key = "p"
})
table.insert(bookmarks, {
  tag = "Chezmoi",
  path = home_path .. path_sep .. ".local/share/chezmoi/",
  key = "z"
})

require("yamb"):setup {
  -- Optional, the path ending with path seperator represents folder.
  bookmarks = bookmarks,
  -- Optional, recieve notification everytime you jump.
  jump_notify = true,
  -- Optional, the cli of fzf.
  cli = "fzf",
  -- Optional, a string used for randomly generating keys, where the preceding characters have higher priority.
  keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
  -- Optional, the path of bookmarks
  path = (os.getenv("HOME") .. "/.config/yazi/bookmark"),
}
require("git"):setup()
require("starship"):setup()

-- ~/.config/yazi/init.lua
-- Modal:children_add({
--   _id = "my-component",
--   new = function(self, area)
--     self._area = self.layout(area)
--     return self
--   end,
--   reflow = function(self) return { self } end,
--   redraw = function(self)
--     return {
--       ui.Clear(self._area),
--       ui.Text("Hello, World!"):area(self._area):bg("blue"):bold(),
--     }
--   end,

--   -- Optional methods:
--   layout = function(area)
--     local chunks = ui.Layout()
--       :constraints({
--         ui.Constraint.Ratio(1, 3),
--         ui.Constraint.Ratio(1, 3),
--         ui.Constraint.Ratio(1, 3),
--       })
--       :split(area)
    
--     local chunks = ui.Layout()
--       :direction(ui.Layout.HORIZONTAL)
--       :constraints({
--         ui.Constraint.Ratio(1, 6),
--         ui.Constraint.Ratio(4, 6),
--         ui.Constraint.Ratio(1, 6),
--       })
--       :split(chunks[2])
--     return chunks[2]
--   end,
--   click = function(self, event, up) end,
--   scroll = function(self, event, step) end,
--   touch = function(self, event, step) end,
-- }, 10)
