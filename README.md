My home directory’s configuration files are managed by Git.  
I use the same configuration on all my important machines:

- My [DigitalOcean] server [`tyto`], on Debian.
- My home server [`shade`], on Linux Mint.
- My main PC [`iceberg`], on OS X.

Features
--------

- Sensible defaults settings for:
  - [`curl`]
  - [`dig`]
  - [EditorConfig]
  - [SQLite]
  - [`Wget`]
- More personal settings for Git (i.e. PGP)
- Encrypted SSH `config` (duh!).
- Vim with [vim-plug] support
  - _TODO: support [neovim]_
- `zshrc`, with [school] and home settings.

Installing
----------

    cd && git init
    git remote set-url --add origin git@github.com:Diti/DotFiles.git
    git fetch
    git rebase origin/master


  [`curl`]: http://curl.haxx.se
  [`dig`]: https://en.wikipedia.org/wiki/dig_(command)
  [DigitalOcean]: https://www.digitalocean.com/?refcode=4e8dbb7743d7
  [EditorConfig]: http://editorconfig.org
  [`iceberg`]: http://iceberg.home.diti.me
  [neovim]: http://neovim.io/
  [school]: http://www.42.fr/
  [`shade`]: http://home.diti.me
  [SQLite]: http://www.sqlite.org
  [`tyto`]: http://tyto.diti.me
  [vim-plug]: https://github.com/junegunn/vim-plug
  [`Wget`]: https://www.gnu.org/software/wget
