-- Dad Bod Plugins
-- sql
return {
  {
    'tpope/vim-dadbod',
    config = function()
      -- Auto-connection for PostgreSQL
      -- Example: postgres://<user>@localhost/<database>
      local user = os.getenv 'USER' -- your system username
      local dbname = user -- if your DB name equals username

      -- Build DSN string
      vim.g.dbs = {
        postgres = string.format('postgres://%s@localhost/%s', user, dbname),
      }
    end,
  },

  -- Dadbod UI
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = { 'tpope/vim-dadbod' },
    config = function()
      -- Optional UI settings
    end,
  },

  -- Dadbod completion
  {
    'kristijanhusak/vim-dadbod-completion',
    dependencies = { 'tpope/vim-dadbod' },
  },
}
