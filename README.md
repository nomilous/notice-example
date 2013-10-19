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
2. [create and export the hub definition]()
3. [create and start a hub instance](https://github.com/nomilous/notice-example/commit/cbd24ea385ded5068e96fd8fc7b46682db056426)

