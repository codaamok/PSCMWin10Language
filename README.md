# PSCMWin10Language
A PowerShell module which helps you create Language Pack, Language Experience Pack and Features on Demand repositories. You can also create a Configuration Manager application which allows users to install new languages from the Software Center using said repositories as source directories.

Read more about the context of this module and how to use it [in my blog post at SysManSquad](https://sysmansquad.com/2020/06/08/deploy-languages-via-software-center-with-pscmwin10language/).

## Functions

- New-LPRepository
- New-LXPRepository
- New-FoDLanguageFeaturesRepository
- New-CMLanguagePackApplication

## Getting started

Install and import:

```powershell
Install-Module PSCMWin10Language -Scope CurrentUser
Import-Module PSCMWin10Language
```

## Examples

```powershell
PS C:\> New-LPRepository -Language "fr-FR", "de-DE" -SourcePath "I:\x64\langpacks" -TargetPath "F:\OSD\Source\1909-Languages"
```

Copies Language Packs named "fr-FR" and "de-DE" from path "I:\LocalExperiencePack" to "F:\OSD\Source\1909-Languages\fr-FR\LP" and "F:\OSD\Source\1909-Languages\de-DE\LP"

___

```powershell
PS C:\> New-LXPRepository -Language "fr-FR", "de-DE" -SourcePath "I:\LocalExperiencePack" -TargetPath "F:\OSD\Source\1909-Languages"
```

Copies Language Experience Packs folders for "fr-FR" and "de-DE" in Language Experience Pack ISO path "I:\LocalExperiencePack" to "F:\OSD\Source\1909-Languages\fr-FR\LXP" and "F:\OSD\Source\1909-Languages\de-DE\LXP"

___

```powershell
PS C:\> New-FoDLanguageFeaturesRepository -Language "fr-FR", "de-DE" -SourcePath "I:\" -TargetPath "F:\OSD\Source\1909-Languages"
```

Copies Features on Demand of LanguageFeatures Basic, Handwriting, OCR, Speech and TextToSpeech with language elements "fr-FR", "de-DE" in path "I:\" to "F:\OSD\Source\1909-Languages\fr-FR\FoD" and "F:\OSD\Source\1909-Languages\de-DE\FoD"

___

```powershell
PS C:\> New-CMLanguagePackApplication -SiteServer "cm.contoso.com" -SiteCode "P01" -SourcePath "\\cm.contoso.com\OSD\Source\1909-Languages" -Languages "fr-fr", "de-de" -WindowsVersion = @{ "Version" = "1909"; "Build" = "18363" } -GlobalConditionName "Operating System build" -CreateAppIfMissing -CreateGlobalConditionIfMissing
```

Adds two new deployment types to applications with names "Windows 10 x64 Language Pack - fr-fr" and "Windows 10 x64 Language Pack - de-de". If the applications do not exist, create them.

The deployment type names are "$version ($build) - Install language items (SYSTEM)" and "$version ($build) - Configure language list (USER)". 

A Global Condition named "Operating System build" will be created if it does not exist.

Install.ps1 is created and stored in "\\\\cm.contoso.com\OSD\Source\1909-Languages".

Deployment type (SYSTEM) has a source path set to "\\\\cm.contoso.com\OSD\Source\1909-Languages" which should contain your LP, LXP and FoDs in a folder structure as e.g. ".\LP\",".\LXP\",".\FoD\". The system deployment type executes Install.ps1 and run this as system. It installs LP, LXP and FoDS. The requirement for this deployment type is set to Windows 10 build 18363 using the Global Condition "Operating System build".

Deployment type (USER) has no source path and runs a series of PowerShell commands to finalise the LXP install for the user, and set the user's current language to the target language. An exit code of 3010 is returned, a reboot is necessary. The requirement for this deployment type is set to Windows 10 build 18363 using the Global Condition "Operating System build". This user deployment type has a dependency on the system deployment type. The user deployment type will have a higher priority than the system deployment type.

___

## Acknowledgements 

Thanks to the following who helped me:

- [SaltyPeaches](https://github.com/saltyPeaches)
- [theaquamarine](https://github.com/theaquamarine)
- [CodyMathis123](https://github.com/codymathis123)
- [asjimene](https://github.com/asjimene)
