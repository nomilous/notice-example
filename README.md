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

1. start `node ./hub` and `node ./client` in separate terminals.



For playing.
------------


```bash

sudo npm install -g node-dev    # unless already
node-dev ./hub                  # so that they restart on change
node-dev ./client
./node_modules/.bin/cake dev    # to auto compile changes to ./src/**/*

```
