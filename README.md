Imagine being able to create [postgresql extensions](https://www.postgresql.org/docs/9.4/static/extend-extensions.html) in rust. Bindings for postgresql 9.4 and 9.5

```
#include "postgres.h"
#include "fmgr.h"
#include "utils/builtins.h"
#include "utils/json.h"
#include "utils/lsyscache.h"
#include "replication/output_plugin.h"
#include "replication/logical.h"
```

Examples
---------------------
[jsoncdc](https://github.com/posix4e/jsoncdc)

[![Join the chat at https://gitter.im/posix4e/jsoncdc](https://badges.gitter.im/posix4e/jsoncdc.svg)](https://gitter.im/posix4e/jsoncdc?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![HuBoard badge](http://img.shields.io/badge/Hu-Board-7965cc.svg)](https://huboard.com/posix4e/jsoncdc)
[![Linux Status](https://travis-ci.org/posix4e/jsoncdc.svg?branch=master)](https://travis-ci.org/posix4e/rpgffi)
[![Chat on Freenode](https://img.shields.io/badge/freenode-%23jsoncdc-brightgreen.svg)](irc://chat.freenode.net/jsoncdc)

