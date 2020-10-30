function Get-AllVms {
    <#
       .SYNOPSIS
            This function will collect basic information on all VMs within a cluster.
    #>
    [CmdletBinding()]
    param (

        [Parameter(Mandatory)]
        [string]$Cluster,
        [string]$sNodes,
        [string]$oVMs

    )

    $oNodes = Invoke-Command -ComputerName $Cluster { 
    
        Get-ClusterNode | select Name
    
    }

    [string[]]$sNodes = Foreach ($oNode in $oNodes) {

        $oNode.Name

    }

    $sessions = New-PSSession -ComputerName $sNodes

    $oVMs = Invoke-Command -Session $sessions -ScriptBlock { 

       Get-VM | select Name, State
   
    }

    $oVMs | ft Name, State
}
