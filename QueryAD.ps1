
if (Get-Module -ListAvailable -Name ActiveDirectory ) {
    Write-Host "ADModule exists" -foregroundcolor green
} else {
	write-host "Installing Active Directory Module..." -foregroundcolor yellow
	.\get-ADTools.ps1 ##RSAT tools to download module
    import-Module ActiveDirectory  #if the active directory module does not exist it will install it
}

$arrayDC = @()
$arrayOU = @() 

#following will ask for OU from a bottom-up approach to feed into the AD command
do {
write-Host "Enter OU container (do not type OU=)[type 'q' to stop]:" -noNewLine -backgroundcolor cyan -foregroundcolor darkMagenta
$OUPart = Read-Host
if ($OUPart -ne '') {$arrayOU += "ou="+$OUPart}
}until ($OUPart -eq 'q') #Loop will stop when user enter 'q' as input

$OUarrayMinusq = $arrayOU | select -skipLast 1
$OU = $OUarrayMinusq -join ","

clear-host

do {
write-Host "Enter DC container (do not type DC=)[type 'q' to stop]:" -noNewLine -backgroundcolor cyan -foregroundcolor darkMagenta
$DCPart = Read-Host
if ($DCPart -ne '') {$arrayDC += "dc="+$DCPart}
}until ($DCPart -eq 'q') #Loop will stop when user enter 'q' as input

$DCarrayMinusq = $arrayDC | select -skipLast 1
$DC = $DCarrayMinusq -join ","

$fullOU = $OU+","+$DC

write-Host "Is " -noNewLine
write-Host "$fullOU " -noNewLine -backgroundcolor black -foregroundcolor cyan
write-Host "correct?[Y/N]" -noNewLine
$confirm = read-Host
if($confirm -eq 'y')
{
	#List all computers from the OU specified
	get-ADComputer -Filter * -SearchBase $fullOU | FT Name > .\OUList.txt
}else {
	write-Host "confirm containers and try again"
}
