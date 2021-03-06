function New-LPRepository {
    <#
    .SYNOPSIS
        Copy out only the Language Packs you want from the Language Pack ISO
    .DESCRIPTION
        Copy out only the Language Packs you want from the Language Pack ISO
    .PARAMETER Langauge
        Language(s) you want to extract, e.g. en-us, fr-fr, de-de etc
    .PARAMETER SourcePath
        Path to where the Language Packs are in the Language Pack ISO
    .PARAMETER TargetPath
        Destination path to copy Language Packs to. A folder per language will be created under this folder.
    .EXAMPLE
        PS C:\> New-LPRepository -Language "fr-FR", "de-DE" -SourcePath "I:\x64\langpacks" -TargetPath "F:\OSD\Source\1909-Languages"

        Copies Language Packs named "fr-FR" and "de-DE" from path "I:\LocalExperiencePack" to "F:\OSD\Source\1909-Languages\fr-FR\LP" and "F:\OSD\Source\1909-Languages\de-DE\LP"
    .NOTES
        Author: Adam Cook (@codaamok)
    #>
    param (
        [Parameter(Mandatory)]
        [ValidateSet('ar-sa', 'bg-bg', 'cs-cz', 'da-dk', 'de-de', 'el-gr', 'en-gb', 'en-us', 'es-es', 'es-mx', 'et-ee', 'fi-fi', 'fr-ca', 'fr-fr', 'he-il', 'hr-hr', 'hu-hu', 'it-it', 'ja-jp', 'ko-kr', 'lt-lt', 'lv-lv', 'nb-no', 'nl-nl', 'pl-pl', 'pt-br', 'pt-pt', 'ro-ro', 'ru-ru', 'sk-sk', 'sl-si', 'sr-la', 'sv-se', 'th-th', 'tr-tr', 'uk-ua', 'zh-cn', 'zh-tw')]
        [String[]]$Language,
        [Parameter(Mandatory)]
        [String]$SourcePath,
        [Parameter(Mandatory)]
        [String]$TargetPath
    )

    Get-ChildItem -Path $SourcePath -Filter '*.cab' | ForEach-Object {
        if ($_.Name -match 'Microsoft-Windows-Client-Language-Pack_x64_([a-z]{2}-[a-z]{2})\.cab') {
            if ($Language -contains $Matches[1]) {
                $Path = '{0}\{1}\LP' -f $TargetPath, $Matches[1]
                if (-not (Test-Path $Path)) {
                    New-Item -Path $Path -ItemType Directory -Force
                }
    
                Copy-Item -Path $_.FullName -Destination $Path -Force
            }
        }
    }
}

function New-LXPRepository {
    <#
    .SYNOPSIS
        Copy out only the folders of the languages you want from the Language Experience Pack ISO
    .DESCRIPTION
        Copy out only the folders of the languages you want from the Language Experience Pack ISO
    .PARAMETER Langauge
        Language(s) you want to extract, e.g. en-us, fr-fr, de-de etc
    .PARAMETER SourcePath
        Path to where the folders of Language Experience Packs are in the Language Experience Pack ISO
    .PARAMETER TargetPath
        Destination path to copy the folders to
    .EXAMPLE
        PS C:\> New-LXPRepository -Language "fr-FR", "de-DE" -SourcePath "I:\LocalExperiencePack" -TargetPath "F:\OSD\Source\1909-Languages"

        Copies Language Experience Packs folders for "fr-FR" and "de-DE" in Language Experience Pack ISO path "I:\LocalExperiencePack" to "F:\OSD\Source\1909-Languages\fr-FR\LXP" and "F:\OSD\Source\1909-Languages\de-DE\LXP"
    .NOTES
        Author: Adam Cook (@codaamok)
    #>
    param (
        [Parameter(Mandatory)]
        [ValidateSet('af-za', 'am-et', 'ar-sa', 'as-in', 'az-latn-az', 'be-by', 'bg-bg', 'bn-bd', 'bn-in', 'bs-latn-ba', 'ca-es', 'ca-es-valencia', 'chr-cher-us', 'cs-cz', 'cy-gb', 'da-dk', 'de-de', 'el-gr', 'en-gb', 'en-us', 'es-es', 'es-mx', 'et-ee', 'eu-es', 'fa-ir', 'fi-fi', 'fil-ph', 'fr-ca', 'fr-fr', 'ga-ie', 'gd-gb', 'gl-es', 'gu-in', 'ha-latn-ng', 'he-il', 'hi-in', 'hr-hr', 'hu-hu', 'hy-am', 'id-id', 'ig-ng', 'is-is', 'it-it', 'ja-jp', 'ka-ge', 'kk-kz', 'km-kh', 'kn-in', 'ko-kr', 'kok-in', 'ku-arab-iq', 'ky-kg', 'lb-lu', 'lo-la', 'lt-lt', 'lv-lv', 'mi-nz', 'mk-mk', 'ml-in', 'mn-mn', 'mr-in', 'ms-my', 'mt-mt', 'nb-no', 'ne-np', 'nl-nl', 'nn-no', 'nso-za', 'or-in', 'pa-arab-pk', 'pa-in', 'pl-pl', 'prs-af', 'pt-br', 'pt-pt', 'quc-latn-gt', 'quz-pe', 'ro-ro', 'ru-ru', 'rw-rw', 'sd-arab-pk', 'si-lk', 'sk-sk', 'sl-si', 'sq-al', 'sr-cyrl-ba', 'sr-cyrl-rs', 'sr-latn-rs', 'sv-se', 'sw-ke', 'ta-in', 'te-in', 'tg-cyrl-tj', 'th-th', 'ti-et', 'tk-tm', 'tn-za', 'tr-tr', 'tt-ru', 'ug-cn', 'uk-ua', 'ur-pk', 'uz-latn-uz', 'vi-vn', 'wo-sn', 'xh-za', 'yo-ng', 'zh-cn', 'zh-tw', 'zu-za')]
        [String[]]$Language,
        [Parameter(Mandatory)]
        [String]$SourcePath,
        [Parameter(Mandatory)]
        [String]$TargetPath
    )
    
    Get-ChildItem -Path $SourcePath | ForEach-Object { 
        if ($Language -contains $_.Name) {
            $Path = '{0}\{1}\LXP' -f $TargetPath, $_.Name
            if (-not (Test-Path $Path)) {
                New-Item -Path $Path -ItemType Directory -Force
            }

            Copy-Item -Path ('{0}\*' -f $_.FullName) -Destination $Path -Force
        }
    }
}

function New-FoDLanguageFeaturesRepository {
    <#
    .SYNOPSIS
        Copy out only the languages you want of the Features on Demand LanguageFeatures Basic, Handwriting, OCR, Speech and TextToSpeech from Features on Demand ISO
    .DESCRIPTION
        Copy out only the languages you want of the Features on Demand LanguageFeatures Basic, Handwriting, OCR, Speech and TextToSpeech from Features on Demand ISO
    .PARAMETER Langauge
        Language(s) you want to extract, e.g. en-us, fr-fr, de-de etc
    .PARAMETER SourcePath
        Path to where the Features on Demand are in the Features on Demand ISO
    .PARAMETER TargetPath
        Destination path to copy Features on Demand to. A folder per language will be created under this folder.
    .EXAMPLE
        PS C:\> New-FoDLanguageFeaturesRepository -Language "fr-FR", "de-DE" -SourcePath "I:\" -TargetPath "F:\OSD\Source\1909-Languages"

        Copies Features on Demand of LanguageFeatures Basic, Handwriting, OCR, Speech and TextToSpeech with language elements "fr-FR", "de-DE" in path "I:\" to "F:\OSD\Source\1909-Languages\fr-FR\FoD" and "F:\OSD\Source\1909-Languages\de-DE\FoD"
    .NOTES
        Author: Adam Cook (@codaamok)
    #>
    param (
        [Parameter(Mandatory)]
        [ValidateSet('ar-SA', 'bg-BG', 'cs-CZ', 'da-DK', 'de-DE', 'el-GR', 'en-GB', 'en-US', 'es-ES', 'es-MX', 'et-EE', 'fi-FI', 'fr-CA', 'fr-FR', 'he-IL', 'hr-HR', 'hu-HU', 'it-IT', 'ja-JP', 'ko-KR', 'lt-LT', 'lv-LV', 'nb-NO', 'nl-NL', 'pl-PL', 'pt-BR', 'pt-PT', 'ro-RO', 'ru-RU', 'sk-SK', 'sl-SI', 'sr-Latn-RS', 'sv-SE', 'th-TH', 'tr-TR', 'uk-UA', 'zh-CN', 'zh-TW')]
        [String[]]$Language,
        [Parameter(Mandatory)]
        [String]$SourcePath,
        [Parameter(Mandatory)]
        [String]$TargetPath
    )

    Get-ChildItem -Path $SourcePath | ForEach-Object {
        if ($_.Name -match 'LanguageFeatures-\w+-([\w]{2}-[\w]{4}-[\w]{2}|[\w]{2}-[\w]{2})') {
            if ($Language -contains $Matches[1]) {
                $Path = '{0}\{1}\FoD' -f $TargetPath, $Matches[1]
                if (-not (Test-Path $Path)) {
                    New-Item -Path $Path -ItemType Directory -Force
                }
    
                Copy-Item -Path $_.FullName -Destination $Path -Force
            }
        }
    }
}

function New-CMLanguagePackApplication {
    <#
    .SYNOPSIS
        Create a Configuration Manager Application with two deployment types to install LP, LXP and FoD (as system) and make the language available to the user in the Settings language list (as user).
    .DESCRIPTION
        Create a Configuration Manager Application with two deployment types to install LP, LXP and FoD (as system) and make the language available to the user in the Settings language list (as user).
    .PARAMETER SiteServer
        FQDN to your site server.
    .PARAMETER SiteCode
        Site code of your ConfigMgr hierarchy for the given SiteServer.
    .PARAMETER SourcePath
        UNC path to the LP, LXP and FoD repositories for each language created using the commands in this module. The folder structure could look like this:

        PS C:\> Get-ChildItem -Path "\\sccm.acc.local\osd\Source\1909-Languages" -Recurse -Depth 1
        
            Directory: \\sccm.acc.local\osd\Source\1909-Languages


        Mode                LastWriteTime         Length Name                                                                                  
        ----                -------------         ------ ----                                                                                  
        d-----       31/05/2020     19:10                de-de                                                                                 
        d-----       31/05/2020     19:09                fr-fr                                                                                 


            Directory: \\sccm.acc.local\osd\Source\1909-Languages\de-de


        Mode                LastWriteTime         Length Name                                                                                  
        ----                -------------         ------ ----                                                                                  
        d-----       29/05/2020     21:25                FoD                                                                                   
        d-----       29/05/2020     21:24                LP                                                                                    
        d-----       29/05/2020     21:26                LXP                                                                                   
        -a----       31/05/2020     20:59            442 Install.ps1                                                                           


            Directory: \\sccm.acc.local\osd\Source\1909-Languages\fr-fr


        Mode                LastWriteTime         Length Name                                                                                  
        ----                -------------         ------ ----                                                                                  
        d-----       29/05/2020     21:25                FoD                                                                                   
        d-----       29/05/2020     21:24                LP                                                                                    
        d-----       29/05/2020     21:26                LXP                                                                                   
        -a----       31/05/2020     20:58            442 Install.ps1                                                                           
    .PARAMETER Languages
        An array of language tags that match the language items in the given -SourcePath. For example, if -SourcePath contains $SourcePath\LP\de-DE, $SourcePath\LXP\de-DE and $SourcePath\FoD\de-DE then -Languages should be "de-DE" (not case sensitive). If you want create more applications for more languages, make use of the array and add more. Make sure you have your LP, LXP and FoD repositories populated with the appropriate cab and appx files.
    .PARAMETER WindowsVersion
        A hashtable which denotes the verison and build number of Windows 10 you're deploying language items for. Must contain two keys: "Version" and "Build". For example:

        PS C:\> @{ "Version" = "1909"; "Build = "18363"}
    .PARAMETER GlobalConditionName
        Name of the Global Condition which queries WMI class Win32_OperatingSystem for property Build. A termianting error is thrown if a Global Condition with the given name does not exist. If it does exist, but does not query class Win32_OperatingSystem for proeprty Build, a termianting error will be thrown. Use -CreateGlobalConditionIfMissing if necessary.
    .PARAMETER CreateAppIfMissing
        If the application(s) of the name "Windows 10 x64 Language Pack - $languagetag" cannot be found, use this switch to create it.
    .PARAMETER CreateGlobalConditionIfMissing
        If the Global Condition "Oeprating System build" is missing, use this switch to create it. 
    .EXAMPLE
        PS C:\> New-CMLanguagePackApplication -SiteServer "cm.contoso.com" -SiteCode "P01" -SourcePath "\\cm.contoso.com\OSD\Source\1909-Languages" -Languages "fr-fr", "de-de" -$WindowsVersion = @{ 'Version' = '1909'; 'Build' = '18363' } -GlobalConditionName 'Operating System build' -CreateAppIfMissing -CreateGlobalConditionIfMissing

        Adds two new deployment types to applications with names "Windows 10 x64 Language Pack - fr-fr" and "Windows 10 x64 Language Pack - de-de". If the applications do not exist, create them.
        The deployment type names are "$version ($build) - Install language items (SYSTEM)" and "$version ($build) - Configure language list (USER)". 
        A Global Condition named "Operating System build" will be created if it does not exist.
        Install.ps1 is created and stored in "\\cm.contoso.com\OSD\Source\1909-Languages".
        Deployment type (SYSTEM) has a source path set to "\\cm.contoso.com\OSD\Source\1909-Languages" which should contain your LP, LXP and FoDs in a folder structure as e.g. ".\LP\",".\LXP\",".\FoD\". The system deployment type executes Install.ps1 and run this as system. It installs LP, LXP and FoDS. The requirement for this deployment type is set to Windows 10 build 18363 using the Global Condition "Operating System build".
        Deployment type (USER) has no source path and runs a series of PowerShell commands to finalise the LXP install for the user, and set the user's current language to the target language. An exit code of 3010 is returned, a reboot is necessary. The requirement for this deployment type is set to Windows 10 build 18363 using the Global Condition "Operating System build". This user deployment type has a dependency on the system deployment type. The user deployment type will have a higher priority than the system deployment type.
    .NOTES
        Author: Adam Cook (@codaamok)
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String]$SiteServer,
        
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [String]$SiteCode,

        [Parameter(Mandatory)]
        [ValidateScript({
            if (-not ([System.Uri]$_).IsUnc) {
                throw '-SourcePath must be a UNC path'
            }
            elseif (-not ([System.IO.Directory]::Exists($_))) {
                throw 'Invalid path or access denied'
            }
            elseif (-not ($_ | Test-Path -PathType Container)) {
                throw '-SourcePath must be a directory, not a file'
            }
            else {
                return $true
            }
        })]
        [String]$SourcePath,

        [Parameter()]
        [String[]]$Languages = @(
            'fr-FR',
            'de-DE'
        ),

        [Parameter()]
        [ValidateScript({
            if (-not ($_.ContainsKey('Version'))) {
                throw 'Please supply a Version key in the hashtable, e.g. Version = 1909'
            }
            elseif (-not ($_.ContainsKey('Build'))) {
                throw 'Please supply a Build key in the hashtable, e.g. Build = 18363'
            }
            elseif ($_['Version'] -notmatch '^[0-9]{4}$') {
                throw 'Please supply a valid Version value in the hashtable, e.g. Version = 1909'
            }
            elseif ($_['Build'] -notmatch '^[0-9]{5}$') {
                throw 'Please supply a valid Build value in the hastable, e.g. Build = 18363'
            }
            else {
                $true
            }
        })]
        [Hashtable]$WindowsVersion = @{
            'Version' = '1909'
            'Build' = '18363' 
        },

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [String]$GlobalConditionName = 'Operating System build',

        [Parameter()]
        [Switch]$CreateAppIfMissing,

        [ParameteR()]
        [Switch]$CreateGlobalConditionIfMissing
    )
    begin {
        $OriginalLocation = (Get-Location).Path

        try {
            if (-not $PSBoundParameters.ContainsKey('SiteCode')) {
                $SiteCode = Get-CimInstance -ComputerName $SiteServer -ClassName 'SMS_ProviderLocation' -Namespace 'ROOT\SMS' -ErrorAction "Stop" | Select-Object -ExpandProperty SiteCode
                if ($SiteCode -isnot [Object] -And $SiteCode.Count -eq 0) {
                    Write-Error -Message 'Could not determine site code, please consider using -SiteCode' -Category 'ObjectNotFound' -ErrorAction 'Stop'
                }
                elseif ($SiteCode.Count -gt 1) {
                    Write-Error -Message ('Found multiple site codes ({0}), please consider using -SiteCode' -f ($SiteCode -join ', ')) -Category 'InvalidData' -TargetObject $SiteCode -ErrorAction 'Stop'
                }
            }
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }

        Import-Module ('{0}\..\ConfigurationManager.psd1' -f $ENV:SMS_ADMIN_UI_PATH) -ErrorAction 'Stop'

        if ($null -eq (Get-PSDrive -Name $SiteCode -PSProvider 'CMSite' -ErrorAction 'SilentlyContinue')) {
            $null = New-PSDrive -Name $SiteCode -PSProvider 'CMSite' -Root $SiteServer -ErrorAction 'Stop'
        }

        Set-Location ('{0}:\' -f $SiteCode) -ErrorAction 'Stop'

        $GlobalCondition_OSBuild = Get-CMGlobalCondition -Name $GlobalConditionName
        $GlobalCondition_OS = Get-CMGlobalCondition -Name 'Operating System' | Where-Object { $_.ModelName -eq 'GLOBAL/OperatingSystem' }

        if ($null -eq $GlobalCondition_OSBuild) {
            if ($CreateGlobalConditionIfMissing.IsPresent) {
                $GlobalCondition_OSBuild = New-CMGlobalConditionWqlQuery -Name 'Operating System build' -Namespace 'root\cimv2' -Class 'Win32_OperatingSystem' -Property 'BuildNumber' -DataType 'String'
            }
            else {
                Write-Error -Message ('Cannot find Global Condition "{0}", consider using -CreateGlobalConditionIfMissing' -f $GlobalConditionName) -Category 'ObjectNotFound' -ErrorAction 'Stop'
            }
        }
        else {
            if (-not ($GlobalCondition_OSBuild.SDMPackageXML | Select-String -SimpleMatch '<WqlQueryDiscoverySource><Namespace>root\cimv2</Namespace><Class>Win32_OperatingSystem</Class><Property>BuildNumber</Property></WqlQueryDiscoverySource>')) {
                Write-Error -Message ('Global Condition "{0}" found, but does not use WQL query with class Win32_OperatingSystem property BuildNumber' -f $GlobalCondition_OSBuild.LocalizedDisplayName) -Category 'ObjectNotFound' -ErrorAction 'Stop'
            }
        }
    }
    process {
        :outer foreach ($Language in $Languages) {
            $ContentLocation = '{0}\{1}' -f $SourcePath, $Language
            $AppName = 'Windows 10 x64 Language Pack - {0}' -f $Language.toUpper()
            $InstallDTName = '{0} ({1}) - Install language items (SYSTEM)' -f $WindowsVersion['Version'], $WindowsVersion['Build']
            $SetLanguageListDTName = '{0} ({1}) - Set language (USER)' -f $WindowsVersion['Version'], $WindowsVersion['Build']
    
            Push-Location $OriginalLocation
            if (-not (Test-Path ('filesystem::{0}' -f $ContentLocation))) {
                Write-Error -Message ('Path "{0}" does not exist, skipping application "{1}"' -f $ContentLocation, $AppName) -Category 'ObjectNotFound'
                continue
            }
            Pop-Location
    
            $AppObj = Get-CMApplication -Name $AppName
    
            if ($null -eq $AppObj) {
                if ($CreateAppIfMissing.IsPresent) {
                    $AppObj = New-CMApplication -Name $AppName
                }
                else {
                    Write-Error -Message ('Cannot find application "{0}", consider using -CreateAppIfMissing' -f $AppName) -Category 'ObjectNotFound'
                    continue
                }
            }
    
            # Check if deployment types already exist, skip language / application if it does
            foreach ($DeploymentType in @($InstallDTName, $SetLanguageListDTName)) {
                $Obj = Get-CMDeploymentType -DeploymentTypeName $DeploymentType -ApplicationName $AppObj.LocalizedDisplayName
                if ($Obj) {
                    Write-Warning -Message ('Deployment type "{0}" already exists for application "{1}", skipping application' -f $dt, $AppName)
                    continue outer
                }
            }
    
            Push-Location $OriginalLocation
            # Build install script for the SYSTEM deployment type
            @(
                '$ErrorActionPreference = "Stop"'
                ''
                '# Install LP and FoD'
                '$cabs = Get-ChildItem -Path ".\LP\",".\FoD\" -Filter "*.cab"'
                'foreach ($cab in $cabs) { Add-WindowsPackage -Online -PackagePath "$($cab.FullName)" -NoRestart }'
                ''
                '# Install LXP'
                '$appx = Get-ChildItem -Path ".\LXP\" -Filter "*.appx" | Select-Object -First 1'
                'Add-AppxProvisionedPackage -Online -PackagePath "$($appx.FullName)" -LicensePath ".\LXP\License.xml"'
                'Start-Sleep -Seconds 60'
            ) | Set-Content -Path $SourcePath\$Language\Install.ps1 -Force -ErrorAction "Stop"

            # Build install script for the USER deployment type
            $UserCommands = @(
                "`$ErrorActionPreference = 'Stop'"
                "`$p = (Get-AppxPackage | Where-Object {{ `$_.Name -like '*LanguageExperiencePack{0}*' }}).InstallLocation" -f $Language
                'Add-AppxPackage -Register -Path $p\AppxManifest.xml -DisableDevelopmentMode'
                '$List = Get-WinUserLanguageList'
                "`$List.Add('{0}')" -f $Language
                'Set-WinUserLanguageList $List -Force'
                "Set-WinUILanguageOverride -Language '{0}'" -f $Language
                'exit 3010'
            ) -join "; "

            $UserInstallString = 'powershell.exe -executionpolicy bypass -noprofile -command "{0}"' -f $UserCommands
    
            # Get FoDs so we can start building detection method
            $FoDs = Get-ChildItem -Path $SourcePath\$Language\FoD -Filter '*.cab'
            Pop-Location

            # Build detection method
            $DetectionMethod = $FoDs | ForEach-Object -Begin {
                # Detection for LP, although LXP adds the same key(s) here too
                New-CMDetectionClauseRegistryKey -Hive 'LocalMachine' -KeyName ('SYSTEM\CurrentControlSet\Control\MUI\UILanguages\{0}' -f $Language) -Existence
                # Detection for LXP
                New-CMDetectionClauseRegistryKey -Hive 'LocalMachine' -KeyName ('SOFTWARE\Microsoft\LanguageOverlay\OverlayPackages\{0}' -f $Language) -Existence
            } -Process {
                # Detection for FoDs
                New-CMDetectionClauseRegistryKey -Hive 'LocalMachine' -KeyName ('SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\PackageIndex\{0}0.0.0.0' -f $_.BaseName) -Existence
            }
    
            $InstallSplat = @{
                ApplicationName          = $AppObj.LocalizedDisplayName
                DeploymentTypeName       = $InstallDTName
                ContentLocation          = $ContentLocation
                InstallCommand           = 'powershell.exe -executionpolicy bypass -noprofile -file ".\Install.ps1"'
                AddDetectionClause       = $DetectionMethod
                UserInteractionMode      = 'Hidden'
                RebootBehavior           = 'NoAction'
                AddRequirement           = @(
                    $GlobalCondition_OSBuild | New-CMRequirementRuleCommonValue -Value1 $WindowsVersion['Build'] -RuleOperator IsEquals
                    $GlobalCondition_OS | New-CMRequirementRuleOperatingSystemValue -PlatformString 'Windows/All_x64_Windows_10_and_higher_Clients' -RuleOperator 'OneOf'
                )
                LogonRequirementType     = 'OnlyWhenUserLoggedOn'
                InstallationBehaviorType = 'InstallForSystem'
                EstimatedRuntimeMins     = 15
                MaximumRuntimeMins       = 60
            }
    
            $InstallDTObj = Add-CMScriptDeploymentType @InstallSplat | ForEach-Object { Get-CMDeploymentType -DeploymentTypeId $_.CI_ID -ApplicationName $AppObj.LocalizedDisplayName }
    
            $SetLanguageListSplat = @{
                ApplicationName          = $AppObj.LocalizedDisplayName
                DeploymentTypeName       = $SetLanguageListDTName
                InstallCommand           = $UserInstallString
                ScriptLanguage           = 'PowerShell'
                ScriptText               = 'if ((Get-WinUserLanguageList).LanguageTag -contains "{0}") {{ Write-Output "Detected" }}' -f $Language
                UserInteractionMode      = 'Hidden'
                RebootBehavior           = 'BasedOnExitCode'
                AddRequirement           = @(
                    $GlobalCondition_OSBuild | New-CMRequirementRuleCommonValue -Value1 $WindowsVersion['Build'] -RuleOperator IsEquals
                    $GlobalCondition_OS | New-CMRequirementRuleOperatingSystemValue -PlatformString 'Windows/All_x64_Windows_10_and_higher_Clients' -RuleOperator 'OneOf'
                )
                InstallationBehaviorType = 'InstallForUser'
                EstimatedRuntimeMins     = 1
                MaximumRuntimeMins       = 15
            }
    
            $SetLanguageListObj = Add-CMScriptDeploymentType @SetLanguageListSplat | ForEach-Object { Get-CMDeploymentType -DeploymentTypeId $_.CI_ID -ApplicationName $AppObj.LocalizedDisplayName }
    
            $null = $SetLanguageListObj | Set-CMDeploymentType -Priority 'Increase'
            $null = $SetLanguageListObj | New-CMDeploymentTypeDependencyGroup -GroupName 'Install language items' | Add-CMDeploymentTypeDependency -DeploymentTypeDependency $InstallDTObj -IsAutoInstall:$true
    
        }
    }
    end {
        Set-Location $OriginalLocation
    }
}
