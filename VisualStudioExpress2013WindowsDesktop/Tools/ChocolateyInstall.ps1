if(Get-Module Boxstarter.Chocolatey){
    if(Test-PendingReboot){
        Invoke-Reboot
    }
}

$ieKey="HKLM:\Software\Microsoft\Internet Explorer"
if(Get-ItemProperty -Path $ieKey -Name "svcVersion" -ErrorAction SilentlyContinue){
    $ieVersion=(Get-ItemProperty -Path $ieKey -Name "svcVersion").svcVersion
    $majorVersion = [int]$ieVersion.Substring(0,2)
    $hasIE10 = $majorVersion -gt 9
}

if($hasIE10 -ne $true){
    throw @"
    You either do not have IE10 installed or you have just installed IE10
    as a dependency of this package and your machine must be rebooted for the IE10
    install to complete. Visual Studio 2013 cannot be installed until the IE10
    installation is complete. For a fully silent install, try using
    http://Boxstarter.org to manage the reboot automatically.
"@
}

Install-ChocolateyPackage 'VisualStudioExpress2013WindowsDesktop' 'exe' "/Passive /NoRestart /Log $env:temp\VisualStudioExpress2013Windows.log" 'http://download.microsoft.com/download/1/4/A/14AB19DE-9E0F-4502-993F-52EBB9BA2D80/winexpress_full.exe'
