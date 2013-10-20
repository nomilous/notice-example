how to [notice](https://github.com/nomilous/notice)
=============

### pre requisites

* `curl` - a commanline http client
* `git`  - too much detail? 
* `node` - the magic 
* `elasticsearch` - also magic
    * examples assume a localhosted instance of [elasticsearch](http://www.elasticsearch.org/) listening at 9200
    * p.s. if you've not explored elasticsearch, i strongly recommend it jumping
    * your todo queue

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

Walkthrough / Possibility Tour
------------------------------

1. start `node ./hub` and `node ./client` in separate terminals.



For playing.
------------


```bash

sudo npm install -g node-dev    # unless already
node-dev ./hub                  # so that they restart on change
node-dev ./client
./node_modules/.bin/cake dev    # to auto compile changes in ./src/**/*

```
