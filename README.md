# M4rshel\bin

This is a small project that makes it possible to share text based files on the internet via a automatic generated.
You only have to send the files content to the server and you will get a link to the file.

## Command

```shell
bin [-path <String>] [-rm] [-ls] [-token <String>] [-serverURI <String>]
```

## Options

- `-path <String>`: The path to the file that should be uploaded **Required**
- `-rm`: Remove a file from the server by providing the fileid in the path argument **Optional**
- `-ls`: List all files on the server **Optional**
- `-token <String>`: The token that is used to authenticate the user **Optional**
- `-serverURI <String>`: The URI of the server **Optional**


**Optional**  
All of the optional arguments are already defined in the function itself and the parameters are only to overwrite the default values or to switch between the functions.

## Upload a file

**Request**

```http
GET / HTTP/1.1
accept: application/json
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

## Delete

**Request**

```http
DELETE /<fileid>?token=<token> HTTP/1.1
accept: application/json
```

example:

```http
DELETE /99RNEH7OD7-index.html?token=<token> HTTP/1.1

or

DELETE /99RNEH7OD7?token=<token> HTTP/1.1
```


## List

**Request**

```http
GET /?ls&token=<token> HTTP/1.1
accept: application/json
```

example:

```http
GET /?ls&token=<token> HTTP/1.1
```

## authentication

You can set a token in the .env file, the token is used to authenticate the user.

```dotenv
TOKEN=<your token>
```

## CLI Functions

It is important to set the `token` and `serverURI` in the function for your shell

after that the can be added to your shell profile file, for example:   
Powershell: `$PROFILE`  
Bash: `~/.bashrc`  
zsh: `~/.zshrc`  
...


