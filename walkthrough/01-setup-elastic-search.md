setup elastic search
--------------------

* needs a java runtime
* elasticsearch
    * [download page](http://www.elasticsearch.org/download/)
    * [setup page](http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/setup.html)

#### recalling approximately what i did

osx

```bash

brew install elasticsearch

# 
# ignored instructions about launching at startup
# instead add an alias to ~/.bash_profile to start and stop at will
# 

vi ~/.bash_profile
```
```
alias dev_start_elastic='elasticsearch -f -D es.config=/usr/local/opt/elasticsearch/config/elasticsearch.yml'
```
```

source ~/.bash_profile

# 
# vi /usr/local/opt/elasticsearch/config/elasticsearch.yml
# -------> SUGGEST: ensure your cluster.name is unique
# startit (using the alias)
# 

dev_start_elastic

...

^C to stop (later)

```
