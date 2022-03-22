# implementation of the question function in powershell
function Question ([Parameter(Mandatory)][string]$Prompt, [string[]]$Valid) {
  $Prompt = !$Valid.Length ? $Prompt : "$Prompt`n($($Valid -join ", "))"

  while ($true) {
    $input = (Read-Host($Prompt)).Trim()
    if((!$Valid.Length) -or ($input -in $Valid)) {
      return $input
    }
    Write-Host "`"$input`" is not a valid answer"
  }
}

Question foo bar, baz