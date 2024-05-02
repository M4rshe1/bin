
function bin
{
    param(
        [string]$path = "",
        [Switch]$rm,
        [Switch]$ls,
        [String]$token = "laskjdflaskjdfhalskdjfhlaksdjfhlkasjsdliksdehbuioerr",
        [String]$serverURI = "https://bin.heggli.dev"
    )
    if ($rm) {
        if ($path -eq "") {
            Write-Host "No fileid provided"
            return
        }

        $headers = @{
            'Content-Type' = 'application/json'
        }
        $body = @{
            token = $token
        }
        Invoke-RestMethod -Uri "$($serverURI)/$($path)?token=$($token)" -Method Delete -Body $body -Headers $headers
        return
    }
    if ($ls) {
        $body = @{
            token = $token
        }
        Invoke-RestMethod -Uri "$($serverURI)" -Method Get -Body $body
        return
    }
    if ($path -eq "") {
        Write-Host "No path provided"
        return
    }
    $content = Get-Content $path -Raw
    $body = @{
        file = $content
        token = $token
        filename = $path.Split("\")[-1].Split("/")[-1]
    }
    Invoke-RestMethod -Uri $serverURI -Method Post -Body $body
}