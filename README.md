how to notice
=============

### pre requisites

* `curl` - a commanline http client
* `git`  - too much detail? 
* `node` - the magic 

### clone and install this repo

```bash
git clone git@github.com:nomilous/notice-example.git # this repo
cd notice-example
npm install
```

### quick tip - to readabilitate pancake json

```bash

#
# only do this if understand what it does
# only do it once
# 

json # -bash: json: command not found
echo "alias json='python -mjson.tool'" >> ~/.bash_profile
# . !$
source ~/.bash_profile

#
# pipe some json through the new alias
#

echo '{"order":"1x","neat json":"with values","and":"alhpabetical"}' | json


```

Walkthrough
-----------

1. start `./hub` and `./client` in separate terminals.
2. [create and export the hub definition](https://github.com/nomilous/notice-example/commit/ab21abf4113eb59d80112f0ce8e73c7d11f767dd)
3. [create and start a hub instance](https://github.com/nomilous/notice-example/commit/748cbae231cc7ae642e3c0d1b58d23ca10738b71)

