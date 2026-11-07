<#
.SYNOPSIS
    Builds the DelphiGoogleMap demo application for one Delphi version.

.DESCRIPTION
    Configures the RAD Studio environment via rsvars.bat and invokes MSBuild on
    "Demo\GoogleMaps\GoogleMapsTest.dproj". The executable goes to
    "Demo\GoogleMaps\Bin\<Platform>", next to the WebView2Loader.dll of that
    platform; the DCUs are kept apart for every Delphi version, in
    "Demo\GoogleMaps\Dcu\<DelphiVersion>\<Platform>".

    The demo compiles the library from source (..\Source in the unit search
    path), so no package has to be installed first.

.PARAMETER DelphiVersion
    Delphi version: D10.4, D11, D12 or D13 (default: D13).

.PARAMETER BDSRoot
    Root folder of RAD Studio installations (default: C:\BDS\Studio).

.PARAMETER Platform
    Target platform: Win32 or Win64 (default: Win32).

.PARAMETER Config
    Build configuration: Debug or Release (default: Release).

.PARAMETER Target
    MSBuild target: Build, Clean or Rebuild (default: Build).

.EXAMPLE
    .\BuildDemo.ps1 -DelphiVersion D12 -Platform Win64
    # Builds the demo with Delphi 12, Win64, Release

.EXAMPLE
    .\BuildDemo.ps1 -Config Debug
#>

param(
    [ValidateSet("D10.4", "D11", "D12", "D13")]
    [string]$DelphiVersion = "D13",

    [string]$BDSRoot = "C:\BDS\Studio",

    [ValidateSet("Win32", "Win64")]
    [string]$Platform = "Win32",

    [ValidateSet("Debug", "Release")]
    [string]$Config = "Release",

    [ValidateSet("Build", "Clean", "Rebuild")]
    [string]$Target = "Build"
)

$ErrorActionPreference = "Stop"

# Map Delphi version to BDS version subfolder
$bdsVersionMap = @{
    "D10.4" = "21.0"
    "D11"   = "22.0"
    "D12"   = "23.0"
    "D13"   = "37.0"
}

$bdsVersion = $bdsVersionMap[$DelphiVersion]
$bdsPath = Join-Path $BDSRoot $bdsVersion
$rsvars = Join-Path $bdsPath "bin\rsvars.bat"

if (-not (Test-Path $rsvars)) {
    Write-Error "rsvars.bat not found at: $rsvars"
    exit 1
}

$demoDir = Join-Path $PSScriptRoot "GoogleMaps"
$projectPath = Join-Path $demoDir "GoogleMapsTest.dproj"
if (-not (Test-Path $projectPath)) {
    Write-Error "Project not found: $projectPath"
    exit 1
}

# The application needs WebView2Loader.dll next to the executable
$binDir = Join-Path $demoDir "Bin\$Platform"
if (-not (Test-Path (Join-Path $binDir "WebView2Loader.dll"))) {
    Write-Host "WARNING: WebView2Loader.dll not found in $binDir" -ForegroundColor Yellow
}

# One DCU folder per Delphi version: DCUs of different compilers can't be mixed
$dcuDir = Join-Path $demoDir "Dcu\$DelphiVersion\$Platform"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " DelphiGoogleMap Demo Build" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Delphi:   $DelphiVersion (BDS $bdsVersion)" -ForegroundColor White
Write-Host " Platform: $Platform" -ForegroundColor White
Write-Host " Config:   $Config" -ForegroundColor White
Write-Host " Target:   $Target" -ForegroundColor White
Write-Host " Output:   $binDir" -ForegroundColor White
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

$msbuildArgs = "`"$projectPath`" /t:$Target /p:Config=$Config /p:Platform=$Platform `"/p:DCC_DcuOutput=$dcuDir`" /v:minimal /nologo"
cmd /c "call `"$rsvars`" && msbuild $msbuildArgs"
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "BUILD FAILED (exit code $LASTEXITCODE)" -ForegroundColor Red
    exit $LASTEXITCODE
}
Write-Host ""
Write-Host "BUILD SUCCEEDED" -ForegroundColor Green
exit 0
