import Config

config :clipboard,
  unix: [
    copy: {"clip.exe", []}
  ]

import_config("config.private.exs")
