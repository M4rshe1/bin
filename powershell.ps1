function bin{
    param(
        [string]$path
    )
    $ServerURI = "https://bin.heggli.dev"
    $token = "laskjdflaskjdfhalskdjfhlaksdjfhlkasjsdliksdehbuioerr"
    $content = Get-Content $path -Raw
    # send a request to 127.0.0.1:8080 with the content as parameter file
    $body = @{
        file = $content
        filename = $path.Split("\")[-1].Split("/")[-1],
        token = $token
    }
    Invoke-RestMethod -Uri "http://127.0.0.1:8000" -Method Get -Body $body
}