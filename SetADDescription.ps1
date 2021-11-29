clear-host
$PC = read-host "What computer do you want to edit?"
$des = read-host "What do you want the description to say?"
$account = read-host "Give me your admin account"


Set-ADComputer -Identity $PC -Credential MW\$account -Description $des
