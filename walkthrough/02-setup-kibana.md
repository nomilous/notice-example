setup kibana
------------

[useful video](http://www.elasticsearch.org/webinars/using-elasticsearch-for-log-search-and-analysis/)

* just needs a way to serve files to the browser
    * [download and setup page](http://www.elasticsearch.org/overview/kibana/installation/)


#### recalling approximately what i did

osx

```bash

brew install wget

#
# there may be a brew for kibana?
# this works too:
# 

mkdir -p ~/tools
cd ~/tools/
wget https://download.elasticsearch.org/kibana/kibana/kibana-3.0.0milestone4.tar.gz
tar -zxf kibana-3.0.0milestone4.tar.gz 
cd kibana-3.0.0milestone4
vi config.js 
```
```bash
# 
# defaults are fine for as long as elastic is on localhost and you access kibana at localhost
# 
```
```bash

#
# serve kibana at localhost
#

sudo npm install -g node-static 

static --help

# 
# USAGE: static [-p <port>] [<directory>]
# 
# simple, rfc 2616 compliant file streaming module for node
# 
# Options:
#   --port, -p         TCP port at which the files will be served        [default: 8080]
#   --cache, -c        "Cache-Control" header setting, defaults to 3600
#   --version, -v      node-static version                             
#   --headers, -H      additional headers (in JSON format)             
#   --header-file, -f  JSON file of additional headers                 
#   --help, -h         display this help message     
#                   

static

# 
# serving "." at http://127.0.0.1:8080
# ^C
# 

#
# alias it in ~/.bash_profile
# 

vi ~/.bash_profile
```
```
alias dev_start_kibana='static -p 2021 ~/tools/kibana-3.0.0milestone4'
```
```bash

source ~/.bash_profile
dev_start_kibana

...

^C to stop (later)

```

#### verify

* push a test-record into elasticsearch

```bash

curl -XPOST localhost:9200/test-index/test-record -d '{"key":"value"}'
# 
# {"ok":true,"_index":"test-index","_type":"test-record","_id":"1zo_YczzRaO-T97_BoHqEQ","_version":1}
# 

```

* browse to kibana (sample deshboard) @ [http://127.0.0.1:2021/index.html#/dashboard/file/guided.json](http://127.0.0.1:2021/index.html#/dashboard/file/guided.json)
* should see a pie chart with the `test-record` in it
* play around...

* delete the test record, using the assigned ID

```bash

curl -XDELETE localhost:9200/test-index/test-record/1zo_YczzRaO-T97_BoHqEQ
# 
# {"ok":true,"found":true,"_index":"test-index","_type":"test-record","_id":"1zo_YczzRaO-T97_BoHqEQ","_version":2}
#

```

* umm, ..., post a json file

```
cd back-to-the-clone-of-this-repo
curl -XPOST -d @package.json localhost:9200/test-index/test-record
```

* very very nice!



