#!/usr/bin/env pwsh

$URLPREFIX = "https://raw.githubusercontent.com/mozilla/gecko/central/extensions/universalchardet/src/base"

$Files = @("CharDistribution.cpp",
    "CharDistribution.h",
    "JISFreq.tab"
    "JpCntx.cpp"
    "JpCntx.h"
    "moz.build"
    "nsCharSetProber.cpp"
    "nsCharSetProber.h"
    "nsCodingStateMachine.h"
    "nsEUCJPProber.cpp"
    "nsEUCJPProber.h"
    "nsEscCharsetProber.cpp"
    "nsEscCharsetProber.h"
    "nsEscSM.cpp"
    "nsLatin1Prober.cpp"
    "nsLatin1Prober.h"
    "nsMBCSGroupProber.cpp"
    "nsMBCSGroupProber.h"
    "nsMBCSSM.cpp"
    "nsPkgInt.h"
    "nsSJISProber.cpp"
    "nsSJISProber.h"
    "nsUTF8Prober.cpp"
    "nsUTF8Prober.h"
    "nsUniversalDetector.cpp"
    "nsUniversalDetector.h")

$wgetexe = "wget"
if ($IsDesktop -or $IsWindows) {
    $wgetexe = "wget.exe"
}

foreach ($F in $Files) {
    Write-Host "download $F"
    if (Test-Path $F) {
        Rename-Item $F "$F.old"
    }
    &$wgetexe "$URLPREFIX/$F"
    if (!(Test-Path $F) -and (Test-Path "$F.old")) {
        Rename-Item "$F.old" $F
    }
    if (Test-Path "$F.old") {
        Remove-Item "$F.old"
    }
}
