#!/usr/bin/env pwsh
# serve.ps1 — Windows PowerShell launcher for the Slime arena viewer.
# PowerShell equivalent of:  SLIME_ROOT=~/.claude/slime node scripts/serve.js
#
# Why this exists: PowerShell does not support the `KEY=val cmd` prefix syntax,
# and it never expands `~` into env-var values — Node would receive a literal
# "~/.claude/slime" path. We set SLIME_ROOT via $env: and expand $HOME ourselves.

$ErrorActionPreference = 'Stop'

# Respect an SLIME_ROOT the caller already set; otherwise mirror the default.
if (-not $env:SLIME_ROOT) {
  $env:SLIME_ROOT = [IO.Path]::Combine($HOME, '.claude', 'slime')
}

$port = if ($env:SLIME_PORT) { $env:SLIME_PORT } else { '4117' }
Write-Host "⚔️  Slime arena → http://127.0.0.1:$port  (Ctrl-C to stop)"

node (Join-Path $PSScriptRoot 'serve.js')
