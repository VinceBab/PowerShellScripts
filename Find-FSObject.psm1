Function Find-FSObject {

    param(
        [Parameter(Mandatory=$true,
                    HelpMessage="Name of object to find.")]
                    [string]$name,

        [Parameter(Mandatory=$false,
                    HelpMessage="Object type (f - file, d - directory")]
                    [ValidateSet("d","f")]
                    [string]$type,

        [Parameter(Mandatory=$false,Position=0)]
                    [string]$startLocation
    )

    $objectType = ""

    if ( $type -eq "d" ) { $objectType = "-Directory" }
    if ( $type -eq "f" ) { $objectType = "-File" }  
    if ( $startLocation -ne "") { $startPath = "-Path $startLocation" }

    # Write-Output "Looking for $objectType - $name (type: $type)"

    $command = "Get-ChildItem $objectType $startPath -Recurse | Where-Object -FilterScript {`$_`.name -match `"$name`"}"

    Invoke-Expression $command
}

Export-ModuleMember -Function Find-FSObject