function bin
{
    param(
        [string]$path
    )
    $serverURI = "https://bin.heggli.dev"
    $token = "laskjdflaskjdfhalskdjfhlaksdjfhlkasjsdliksdehbuioerr"
    $content = Get-Content $path -Raw
    $body = @{
        file = $content
        filename = $path.Split("\")[-1].Split("/")[-1]
        token = $token
    }
    Invoke-RestMethod -Uri $serverURI -Method Get -Body $body
}

function binrm
{
    param(
        [string]$fileid
    )
    $serverURI = "https://bin.heggli.dev/rm/"
    $serverURI += $fileid
    $token = "laskjdflaskjdfhalskdjfhlaksdjfhlkasjsdliksdehbuioerr"
    $body = @{
        token = $token
    }
    Invoke-RestMethod -Uri $serverURI -Method Get -Body $body
}