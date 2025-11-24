# Troubleshooting Notes for Neovim Setup

- Fix broken icons
  - Download [nerdfix](https://github.com/loichyan/nerdfix) binary and unpack in home directory.
  - Run `nerdfix check <path/to/file>` to check broken icons in a file
  - Run `nerdfix fix <path/to/file>` to fix broken icons in a file

- nvim external dependencies:
  1. Install Node.js (recommended via Node Version Manager nvm)
    ```curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash-language-server```

    Restart your terminal:
      ```source ~/.bashrc```

    then:
      ```nvm install --lts```
      ```nvm use --lts```

    Confirm:
      ```node -v```
      ```npm -v```

  2. Reopen Neovim and install tools again
    - Inside nvim:
      ```:Mason```
    
    - Then reinstall:
      ```:MasonInstall eslint_d prettier bash-language-server html-lsp json-lsp```
