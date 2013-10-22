I am lazy
---------

#### i have this alias for json readabilitation

```bash

alias json='python -mjson.tool'

```

#### from now on i won't type localhost, because i don't need to

not all curls can do that

```bash

curl -s -XPOST :9200/track/lorries -d '{

    "tag": "redlorry",
    "mark": {
        "timestamp": "1970-00-00T00:00:00.001Z",
        "location" : [0.0, 0.0]
    }

}
' | json 
```
```json
{
    "_id": "seDtEGztTO2vXrw5a82M9Q", 
    "_index": "track", 
    "_type": "lorries", 
    "_version": 1, 
    "ok": true
}
```
