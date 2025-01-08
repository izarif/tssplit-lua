# Trivial split for Lua

Lua implementation of [tssplit](https://github.com/mezantrop/tssplit/) python package

<a href="https://boosty.to/izarif/donate"><img src="boostyButton.png" alt="Donate via Boosty"></a>

## Usage

```lua
local ts = require("tssplit")

ts.split('--:--;--,--"--/--"--\'--:--\'--/"--^--',
        {quote="\"'", delimiter=":;,", escape="/^", trim=""})

--> {'--', '--', '--', '----/------:----"----'}

ts.split('--:--;--,--"--/--"--\'--:--\'--/"--^--',
        {quote="\"'", delimiter=":;,", escape="/^", trim="", quoteKeep=true})

--> {'--', '--', '--', '--"--/--"--\'--:--\'--"----'}

ts.split('--:--;--,--"--/--"--\'--:--\'--# Ignore this',
        {quote="\"'", delimiter=":;,", escape="/^", trim="", quoteKeep=true, remark="#"})

--> {'--', '--', '--', '--"--/--"--\'--:--\'--'}
```
