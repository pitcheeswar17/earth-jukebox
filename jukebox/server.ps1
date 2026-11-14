# Simple PowerShell HTTP Server for Earth Jukebox
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://127.0.0.1:8080/")
$listener.Prefixes.Add("http://localhost:8080/")
$listener.Start()
Write-Host "Earth Jukebox server running at http://localhost:8080/"
$root = "c:\jukebox"

while ($listener.IsListening) {
    try {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response

        $relPath = $request.Url.LocalPath
        if ($relPath -eq "/" -or [string]::IsNullOrWhiteSpace($relPath)) {
            $relPath = "/index.html"
        }

        $filePath = Join-Path $root ($relPath.TrimStart('/').Replace('/', '\'))

        if (Test-Path $filePath -PathType Leaf) {
            $bytes = [System.IO.File]::ReadAllBytes($filePath)
            $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
            $contentType = switch ($ext) {
                ".html" { "text/html; charset=utf-8" }
                ".js"   { "application/javascript; charset=utf-8" }
                ".css"  { "text/css; charset=utf-8" }
                ".csv"  { "text/csv; charset=utf-8" }
                ".json" { "application/json; charset=utf-8" }
                default { "application/octet-stream" }
            }
            $response.ContentType = $contentType
            $response.ContentLength64 = $bytes.Length
            $response.StatusCode = 200
            $response.OutputStream.Write($bytes, 0, $bytes.Length)
        } else {
            $response.StatusCode = 404
            $notFound = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
            $response.ContentLength64 = $notFound.Length
            $response.OutputStream.Write($notFound, 0, $notFound.Length)
        }
        $response.OutputStream.Close()
    } catch {
        # ignore context errors on shutdown
    }
}
