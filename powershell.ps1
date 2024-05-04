function cb
{
    param(
        [string]$path = "",
        [string]$rm,
        [Switch]$ls,
        [String]$token = "laskjdflaskjdfhalskdjfhlaksdjfhlkasjsdliksdehbuioerr",
        [String]$serverURI = "https://bin.heggli.dev"
    )
    if ($rm) {
        if ($rm -eq "") {
            Write-Host "No fileid provided" -ForegroundColor Red
            return
        }

        $headers = @{
            'Content-Type' = 'application/json'
        }
        $body = @{
            token = $token
        }
        Invoke-RestMethod -Uri "$($serverURI)/$($rm)?token=$($token)" -Method Delete -Body $body -Headers $headers
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
        Write-Host "No path provided" -ForegroundColor Red
        return
    }
    if (-not (Test-Path $path)) {
        Write-Host "File not found" -ForegroundColor Red
        return
    }
    $content = Get-Content $path -Raw
    $body = @{
        file = $content
        token = $token
        filename = $path.Split("\")[-1].Split("/")[-1]
    }
    Invoke-RestMethod -Uri $serverURI -Method Get -Body $body -InFile $path
}