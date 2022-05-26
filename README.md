# cheat
This is a very simple "cheat" command. 
The function is simply to list the markdown heading 2 (## title) with fzf and open the selected section in vim.



## Installation
```
% make install
```


### Dependencies
- fzf: https://github.com/junegunn/fzf



## Usage
```
% cheat --help
```


### How to create cheat sheet
```
% mkdir xxx directory
% cat << EOF > xxx/yyy.md
## title
Contents
...
EOF
% export CHEAT_BASE_PATH="`pwd`/xxx"
```

See: sheet/sample{1,2}.md

