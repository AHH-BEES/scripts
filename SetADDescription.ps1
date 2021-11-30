clear-host
$PC = read-host "What computer do you want to edit?"
$des = read-host "What do you want the description to say?"
$account = read-host "Enter your admin account, with domain. (If current account is priviledged then put n/a)"

if ($account !eq 'n/a')
  Set-ADComputer -Identity $PC -Credential $account -Description $des
else 
  Set-ADComputer -Identity $PC  -Description $des
