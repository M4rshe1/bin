# M4rshel\bin

This is a small project that makes it possible to share text based files on the internet via a automatic generated.
You only have to send the files content to the server and you will get a link to the file.


## Upload a file
**Request**


```http
GET / HTTP/1.1
accept: application/json
```

**body**


```json
{
    "file": "Hello World!",
    "filename": "hello.txt",
    "token": "your token"
}
```


**Response**


```text/plain
https://<hostname>:<port>/<fileid>
```

example:


```text/plain
https://example.com:8080/99RNEH7OD7-index.html
```

## Get file


**Request**


```http
GET /<fileid> HTTP/1.1
accept: application/json
```


example:  


```http
GET /99RNEH7OD7-index.html HTTP/1.1

or 

GET /99RNEH7OD7 HTTP/1.1
```


**Response**


```text/plain
Hello World!
```


## auth


You can set a token in the main.py file to secure the upload of files.  


```python
TOKEN = "your token"
```


## CLI Functions
It is important to set the `token` and `serverURI` in the function for your shell   

after that the can be added to your shell profile file, for example:   
Powershell: `$PROFILE`  
Bash: `~/.bashrc`  
zsh: `~/.zshrc`  
...   




