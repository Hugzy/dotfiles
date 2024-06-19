return {
    'pwntester/octo.nvim',
    requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        -- OR 'ibhagwan/fzf-lua',
        'nvim-tree/nvim-web-devicons',
    },
    config = function ()
        require"octo".setup({
            use_local_fs = false,                    -- use local files on right side of reviews
            enable_builtin = false,                  -- shows a list of builtin actions when no action is provided
            default_remote = {"upstream", "origin"}; -- order to try remotes
            default_merge_method = "commit",         -- default merge method which should be used when calling `Octo pr merge`, could be `commit`, `rebase` or `squash`
            ssh_aliases = {},                        -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`
            picker = "telescope",                    -- or "fzf-lua"
            picker_config = {
                use_emojis = false,                    -- only used by "fzf-lua" picker for now
                mappings = {                           -- mappings for the pickers
                open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
                copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
                checkout_pr = { lhs = "<C-o>", desc = "checkout pull request" },
                merge_pr = { lhs = "<C-r>", desc = "merge pull request" },
            },
        },
        comment_icon = "▎",                      -- comment marker
        outdated_icon = "󰅒 ",                    -- outdated indicator
        resolved_icon = " ",                    -- resolved indicator
        reaction_viewer_hint_icon = " ";        -- marker for user reactions
        user_icon = " ";                        -- user icon
        timeline_marker = " ";                  -- timeline marker
        timeline_indent = "2";                   -- timeline indentation
        right_bubble_delimiter = "";            -- bubble delimiter
        left_bubble_delimiter = "";             -- bubble delimiter
        github_hostname = "";                    -- GitHub Enterprise host
        snippet_context_lines = 4;               -- number or lines around commented lines
        gh_cmd = "gh",                           -- Command to use when calling Github CLI
        gh_env = {},                             -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
        timeout = 5000,                          -- timeout for requests between the remote server
        default_to_projects_v2 = false,          -- use projects v2 for the `Octo card ...` command by default. Both legacy and v2 commands are available under `Octo cardlegacy ...` and `Octo cardv2 ...` respectively.
        ui = {
            use_signcolumn = true,                 -- show "modified" marks on the sign column
        },
        issues = {
            order_by = {                           -- criteria to sort results of `Octo issue list`
            field = "CREATED_AT",                -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
            direction = "DESC"                   -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
        }
    },
    pull_requests = {
        order_by = {                           -- criteria to sort the results of `Octo pr list`
        field = "CREATED_AT",                -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
        direction = "DESC"                   -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
    },
    always_select_remote_on_create = false -- always give prompt to select base remote repo when creating PRs
},
file_panel = {
    size = 10,                             -- changed files panel rows
    use_icons = true                       -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
},
colors = {                               -- used for highlight groups (see Colors section below)
white = "#ffffff",
grey = "#2A354C",
black = "#000000",
red = "#fdb8c0",
dark_red = "#da3633",
green = "#acf2bd",
dark_green = "#238636",
yellow = "#d3c846",
dark_yellow = "#735c0f",
blue = "#58A6FF",
dark_blue = "#0366d6",
purple = "#6f42c1",
  },
  mappings_disable_default = false,        -- disable default mappings if true, but will still adapt user mappings
  mappings = {
      pull_request = {
          checkout_pr = { lhs = "<space>po", desc = "checkout PR" },
          list_commits = { lhs = "<space>pc", desc = "list PR commits" },
          list_changed_files = { lhs = "<space>pf", desc = "list PR changed files" },
          show_pr_diff = { lhs = "<space>pd", desc = "show PR diff" },
          goto_file = { lhs = "gf", desc = "go to file" },
          add_comment = { lhs = "<space>ca", desc = "add comment" },
          review_start = { lhs = "<space>vs", desc = "start a review for the current PR" },
          review_resume = { lhs = "<space>vr", desc = "resume a pending review for the current PR" },
      },
      review_diff = {
          submit_review = { lhs = "<leader>vs", desc = "submit review" },
          discard_review = { lhs = "<leader>vd", desc = "discard review" },
          add_review_comment = { lhs = "<space>ca", desc = "add a new review comment" },
          add_review_suggestion = { lhs = "<space>sa", desc = "add a new review suggestion" },
          focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
          toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
          next_thread = { lhs = "]t", desc = "move to next thread" },
          prev_thread = { lhs = "[t", desc = "move to previous thread" },
          select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
          select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
          select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
          select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
          close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
          toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
          goto_file = { lhs = "gf", desc = "go to file" },
      },
      file_panel = {
          submit_review = { lhs = "<leader>vs", desc = "submit review" },
          discard_review = { lhs = "<leader>vd", desc = "discard review" },
          next_entry = { lhs = "j", desc = "move to next changed file" },
          prev_entry = { lhs = "k", desc = "move to previous changed file" },
          select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
          refresh_files = { lhs = "R", desc = "refresh changed files panel" },
          focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
          toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
          select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
          select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
          select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
          select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
          close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
          toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
      },
  },
    })
end
}
