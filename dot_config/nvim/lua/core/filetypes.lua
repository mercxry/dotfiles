vim.filetype.add {
  extension = {
    tf = "terraform",
    tfvars = "terraform-vars",
    astro = "astro",
    sql = "pgsql",
    gd = "gdscript",
  },
  pattern = {
    [".*%.conf%.d/.*%.conf"] = "nginx",
    [".*justfile.*"] = "just",
    ["rclone.conf"] = "ini",
  },
}
