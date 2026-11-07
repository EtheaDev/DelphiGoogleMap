<#
.SYNOPSIS
    Builds the DelphiGoogleMap demo application for Delphi 11.

.DESCRIPTION
    Calls BuildAllDemos.ps1 -DelphiVersion D11.

.PARAMETER BDSRoot
    Root folder of RAD Studio installations (default: C:\BDS\Studio).

.PARAMETER Platform
    Target platform: Win32, Win64 or Both (default: Both).

.PARAMETER Config
    Build configuration: Debug or Release (default: Release).

.PARAMETER Target
    MSBuild target: Build, Clean or Rebuild (default: Rebuild).

.EXAMPLE
    .\BuildDemoD11.ps1 -Platform Win32 -Config Debug
#>
param(
    [string]$BDSRoot = "C:\BDS\Studio",

    [ValidateSet("Win32", "Win64", "Both")]
    [string]$Platform = "Both",

    [ValidateSet("Debug", "Release")]
    [string]$Config = "Release",

    [ValidateSet("Build", "Clean", "Rebuild")]
    [string]$Target = "Rebuild"
)

$BuildAll = Join-Path $PSScriptRoot "BuildAllDemos.ps1"
& $BuildAll -DelphiVersion "D11" -BDSRoot $BDSRoot -Platform $Platform -Config $Config -Target $Target
exit $LASTEXITCODE
