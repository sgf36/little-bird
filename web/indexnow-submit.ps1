<#
.SYNOPSIS
    Ping IndexNow so Bing / DuckDuckGo / Yandex / Seznam re-crawl changed pages
    within minutes instead of waiting for the next scheduled crawl. (Google does
    not participate in IndexNow — use Search Console's Request Indexing there.)

.DESCRIPTION
    IndexNow works off a key published at the site root:
        https://wren.spencerfields.com/9afd96aa193dc3e072bdd49fb071c0d3.txt
    A single submission to any participating engine is shared with all of them.
    The key is public by design; it proves only that whoever submits also
    controls the site.

    Run after deploying a page change. With no arguments it submits every
    indexable page (the same set as sitemap.xml). Pass -Urls to submit only the
    pages you actually changed — that is the whole point of IndexNow, so prefer
    it over blasting the full list on every edit.

        .\web\indexnow-submit.ps1
        .\web\indexnow-submit.ps1 -Urls "https://wren.spencerfields.com/support.html"

    Note: -Urls takes an array, so the script must be invoked with the call
    operator rather than `pwsh -File`, which would flatten a comma-separated
    list into one string and silently submit a single invalid URL:

        & .\web\indexnow-submit.ps1 -Urls @("https://…/a.html","https://…/b.html")
#>
[CmdletBinding()]
param(
    [string[]]$Urls
)

$ErrorActionPreference = "Stop"

$host_    = "wren.spencerfields.com"
$key      = "9afd96aa193dc3e072bdd49fb071c0d3"
$keyUrl   = "https://$host_/$key.txt"

# Default to the full indexable set (mirrors web/sitemap.xml).
if (-not $Urls -or $Urls.Count -eq 0) {
    $Urls = @(
        "https://$host_/",
        "https://$host_/support.html",
        "https://$host_/privacy.html",
        "https://$host_/terms.html"
    )
}

$body = @{
    host        = $host_
    key         = $key
    keyLocation = $keyUrl
    urlList     = $Urls
} | ConvertTo-Json

Write-Host "Submitting $($Urls.Count) URL(s) to IndexNow ..."
try {
    $resp = Invoke-WebRequest -Uri "https://api.indexnow.org/indexnow" `
        -Method Post -ContentType "application/json; charset=utf-8" `
        -Body $body -UseBasicParsing
    # 200 = accepted, 202 = accepted/queued. Both are success.
    Write-Host ("IndexNow responded HTTP {0} {1}" -f [int]$resp.StatusCode, $resp.StatusDescription)
    if ([int]$resp.StatusCode -in 200,202) { Write-Host "Submitted OK." }
} catch {
    $code = $_.Exception.Response.StatusCode.value__
    Write-Host "IndexNow error: HTTP $code"
    Write-Host "  400 invalid format · 403 key not found/valid at keyLocation · 422 URL/host mismatch · 429 too many requests"
    throw
}
