$userPass = "123Password!"
$names = Get-Content "C:\Users\aniltkl\Desktop\usernames.txt"

$password = ConvertTo-SecureString $userPass -AsPlainText -Force
$domain   = (Get-ADDomain).DistinguishedName

foreach ($line in $names) {
    $first = $line.Trim().Split(" ")[0].ToLower()
    $last  = $line.Trim().Split(" ")[1].ToLower()
    $user  = "$($first[0])$last"
    
    Write-Host "Creating user: $user"
    
    New-ADUser -AccountPassword $password `
               -GivenName $first `
               -Surname $last `
               -DisplayName $user `
               -Name $user `
               -EmployeeID $user `
               -PasswordNeverExpires $true `
               -Path "OU=1USERS,$domain" `
               -Enabled $true
}