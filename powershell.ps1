function bin
{
    param(
        [string]$path
    )
    $ServerURI = "https://bin.heggli.dev"
    $token = "laskjdflaskjdfhalskdjfhlaksdjfhlkasjsdliksdehbuioerr"
    $content = Get-Content $path -Raw
    $body = @{
        file = $content
        filename = $path.Split("\")[-1].Split("/")[-1]
        token = $token
    }
    Invoke-RestMethod -Uri $ServerURI -Method Get -Body $body
}