local status_ok, neo_tree = pcall(require, "neo-tree")
if not status_ok then
  return
end

neo_tree.setup {
    close_if_last_window = false,
    enable_git_status = true,
    enable_diagnostics = true,
    filesystem = {
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
        },
        use_libuv_file_watcher = true,
        follow_current_file = {
            enabled = false,
        },
    },
}
