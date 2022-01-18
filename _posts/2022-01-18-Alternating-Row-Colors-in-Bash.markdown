---
layout: post
title: 'Alternating Row Colors in Bash'
date: '2022-01-18 09:44:23 -0600'
categories: post code bash
---

If you have plain-text table output in bash it's often nice to be able to see that with alternating row colors. This function will do just that:

```bash
function colorTable(){
    if [[ ${COLOR_ROWS_ENABLED:-true} == true ]]; then
        read -r -d $'\n' line || [[ -n "$line" ]] || return 0
        echo -e "\e[1;38;5;${COLOR_ROWS_TEXT_FIRST:-187};48;5;${COLOR_ROWS_BG_FIRST:-232}m$line\e[0m"
        while IFS=$'\n' read -r -d $'\n' line || [[ -n "$line" ]]; do
          echo -e "\e[38;5;${COLOR_ROWS_TEXT:-187};48;5;${COLOR_ROWS_BG_1:-234}m$line\e[0m"
          read -r -d $'\n' line || [[ -n "$line" ]] || break
          echo -e "\e[38;5;${COLOR_ROWS_TEXT:-187};48;5;${COLOR_ROWS_BG_2:-232}m$line\e[0m"
        done
    else
        cat
    fi
}
```

You can test this by saving the function somewhere useful (your profile) and then running a script like this:

```
for (( i=0; i<10; i++ )); do 
    for j in {a..f}; do
        echo -n "$i-$j ";
    done;
    echo;
done | column -t | colorTable
```

