<#
.SYNOPSIS
    ALOS Image Tools - A comprehensive Windows image management utility.
.DESCRIPTION
    A comprehensive tool built by Aarav Katariya designed to simplify your experience when dealing with WIM, ESD, SWM, ISO and IMG files. Built for and around casual users and advanced users so you do not have to remember those long command lines.
    Legal {
        Copyright (C) 2023-2026 Aarav Katariya

        This program is free software: you can redistribute it and/or modify
        it under the terms of the GNU Affero General Public License as published by
        the Free Software Foundation, either version 3 of the License, or
        (at your option) any later version.

        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU Affero General Public License for more details.

        You should have received a copy of the GNU Affero General Public License
        along with this program.  If not, see <https://www.gnu.org/licenses/>.

        Wimlib-imagex.exe is licensed under the GNU General Public License version 3
        or any later version. That is, for Windows builds. This program just calls a
        compiled exe AS A SEPARATE PROCESS even though the code of wimlib-imagex can
        be combined. Aarav Katariya chose not to combine them to avoid a combined work
        which will have to be Affero GPL licensed (because AGPL is stricter than GPL).
    }
    Feel free to ask me why I use 2023-20XX instead of only 20XX.
.PARAMETER Op
    This is a mandatory parameter.
    Specifies the operation to perform on the image file. Valid values {
        Capture - Create a new WIM file from a directory or volume.
        Append - Add a new image to an existing WIM file.
        SaveWIM - Image a drive to a WIM file of your choice.
        SaveESD - Image a drive to an ESD file of your choice.
        SaveSWM - Image a drive to multiple, split SWM files of your choice.
        ConvertToWIM - Convert ESD file to WIM format.
        ConvertToESD - Convert WIM file to ESD format.
        RecompressWIM - Optimise WIM file.
        RecompressESD - Optimise ESD file.
        ExportWIM - Export image indices to a new WIM file.
        ExportESD - Export image indices to a new ESD file.
        Apply - Apply an image to a target directory or volume. Pass -InstallingWindows to install Windows onto a drive of your choice.
        ApplyAndDeleteImage - Apply image and delete the source index afterward.
        Mount - Mount a WIM image for modification.
        ExtractWIM - Extract embedded WIM files from a container.
        ExtractESD - Extract embedded ESD files from a container.
        ExtractSWM - Extract embedded SWM files from a container.
        CreateISOWIM - Create bootable ISO from ESD file using install.wim as the install source.
        CreateISOESD - Create bootable ISO from ESD file using install.esd as the install source.
        GetInfo - Display detailed image information and file hashes.
        SplitWIM - Split a WIM file into smaller SWM parts.
        DeleteImage - Delete one or more image indices from a WIM file.
        JoinWIM - Join a split wimfile and it's parts to a standard WIM file.
        JoinESD - Join a split wimfile and it's parts to a standard WIM file and then convert it to a far smaller ESD file.
        ChangeBootIndexWIM - Read a wim file and change it's boot index without something like GimageX. Eg, change a wimfile's boot index from 1 to 2.
        ChangeImageInfo - Read a wim file and change it's whole image metadata to your liking.
    }
.PARAMETER Path
    This is a mandatory parameter.
    This is capable of specifying the source file or directory.
    If you ever capture or append, please select the directory or the drive.
    If you ever do a standard op like GetInfo, please select the wim, esd or swm file.
    If you ever do ExtractWIM, ExtractESD or ExtractSWM, please select the ISO or IMG file.
.PARAMETER InstallingWindows
    Only works with Apply operation.
    When specified, it can help you install Windows. I promise it is really good!
.PARAMETER WPFUI
    This is a switch meaning it is optional.
    Decide if you want to use the Windows Presentation Foundation over Windows Forms.
    Use Windows Presentation Foundation for all GUI's instead of Windows Forms.
    Trust me. It is far better.
.PARAMETER NoHashes
    This is a switch meaning it is optional.
    Decide if you want the file hashes or not.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op Capture -Path "C:\MyFolder"
    Captures a directory into a new WIM image.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op Append -Path "C:\MyFolder"
    Appends a directory to an existing WIM image.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op SaveWIM -Path "D:\"
    Image a drive to a WIM file of your choice.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op SaveESD -Path "D:\"
    Image a drive to an ESD file of your choice.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op SaveSWM -Path "D:\"
    Image a drive to multiple, split SWM files of your choice.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op ConvertToWIM -Path "C:\install.esd"
    Converts an ESD file to WIM format.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op ConvertToESD -Path "C:\install.wim"
    Converts a WIM file to ESD format.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op RecompressWIM -Path "C:\install.wim"
    Recompresses and optimises a WIM file.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op RecompressESD -Path "C:\install.esd"
    Recompresses and optimises an ESD file.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op ExportWIM -Path "C:\install.wim"
    Exports selected indices to a new WIM file.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op ExportESD -Path "C:\install.esd"
    Exports selected indices to a new ESD file.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op Apply -Path "C:\install.wim"
    Applies an image to a target directory or volume.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op Apply -Path "C:\install.wim" -InstallingWindows
    Installs Windows to a drive.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op ApplyAndDeleteImage -Path "C:\install.wim"
    Applies an image and deletes the source index afterward.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op Mount -Path "C:\install.wim"
    Mounts a WIM image for modification.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op ExtractWIM -Path "C:\image.iso"
    Extracts embedded WIM files from a container
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op ExtractESD -Path "C:\image.iso"
    Extracts embedded ESD files from a container.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op ExtractSWM -Path "C:\image.iso"
    Extracts embedded SWM files from a container.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op CreateISOWIM -Path "C:\install.esd"
    Creates a bootable ISO with install.wim as installation source.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op CreateISOESD -Path "C:\install.esd"
    Creates a bootable ISO with install.esd as installation source.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op GetInfo -Path "C:\install.wim"
    Displays detailed information and hashes for the image.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op SplitWIM -Path "C:\install.wim"
    Splits a WIM file into multiple SWM parts.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op DeleteImage -Path "C:\install.wim"
    Deletes one or more indices from a WIM file.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op JoinWIM -Path C:\MySplitWims\data.swm
    Join a split wimfile and it's parts to a standard WIM file.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op JoinESD -Path C:\MySplitWims\data.swm
    Join a split wimfile and it's parts to a standard WIM file and then convert it to a far smaller ESD file.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op ChangeBootIndexWIM -Path C:\boot.wim
    Read a wim file and change it's boot index without something like GimageX.
    Eg, change a wimfile's boot index from 1 to 2.
.EXAMPLE
    .\ALOS-ImageTools.ps1 -Op ChangeImageInfo -Path C:\data.wim
    Read a wim file and change it's whole image metadata to your liking.
.NOTES
    Author: Aarav Katariya
    Version: 1.0
    Dependencies:
        - Windows PowerShell 5.1 (Built-in), NOT PowerShell Core (separate app). (To minimise dependencies.)
        - wimlib-imagex.exe - Required for all WIM/ESD operations.
        - 7z.exe - Required for extraction operations.
        - Administrator privileges (Built-in) - Required to even launch.
        - DISM module (Built-in) - Required for mount operation.
    Variables:
        $env:WimManage - Can override the path to wimlib-imagex.exe.
    Exit Codes:
        0 - Operation completed successfully.
        1 - Operation failed.
        2 - Relaunched as admin (normal).
        9009 - Unknown operation specified. (Unused. Thanks ValidateSet!)
    Credits:
        Igor Pavlov - 7-Zip
        Eric Biggers - wimlib-imagex
        abbodi1406 - ESD Decryptor (Used as ISO creator)
    Additional Notes:
        Official ESD downloads (limited) - https://worproject.com/esd
        Official ESD downloads (complete) - https://files.rg-adguard.net/version/83fb91c9-107c-bdda-1ffc-2952d753a472?dark=1
        The program requires Windows PowerShell 5.1 not PowerShell Core 6 or 7 and must run with administrator privileges for all operations. If you do not, I will relaunch as admin.
=========================================================================================
                     Every Windows PowerShell 5.1 type and accelerator.
=========================================================================================
Key                          Value
---                          -----
ValidateScript               System.Management.Automation.ValidateScriptAttribute
ValidateSet                  System.Management.Automation.ValidateSetAttribute
ValidateRange                System.Management.Automation.ValidateRangeAttribute
ValidateNotNullOrEmpty       System.Management.Automation.ValidateNotNullOrEmptyAttribute
ValidatePattern              System.Management.Automation.ValidatePatternAttribute
ValidateTrustedData          System.Management.Automation.ValidateTrustedDataAttribute
ipaddress                    System.Net.IPAddress
DscLocalConfigurationManager System.Management.Automation.DscLocalConfigurationManagerAttribute
void                         System.Void
ValidateUserDrive            System.Management.Automation.ValidateUserDriveAttribute
version                      System.Version
ValidateNotNull              System.Management.Automation.ValidateNotNullAttribute
timespan                     System.TimeSpan
uint16                       System.UInt16
securestring                 System.Security.SecureString
cultureinfo                  System.Globalization.CultureInfo
bigint                       System.Numerics.BigInteger
uint32                       System.UInt32
ValidateDrive                System.Management.Automation.ValidateDriveAttribute
ValidateLength               System.Management.Automation.ValidateLengthAttribute
ValidateCount                System.Management.Automation.ValidateCountAttribute
uint64                       System.UInt64
uri                          System.Uri
WildcardPattern              System.Management.Automation.WildcardPattern
runspacefactory              System.Management.Automation.Runspaces.RunspaceFactory
runspace                     System.Management.Automation.Runspaces.Runspace
powershell                   System.Management.Automation.PowerShell
type                         System.Type
psmoduleinfo                 System.Management.Automation.PSModuleInfo
initialsessionstate          System.Management.Automation.Runspaces.InitialSessionState
psaliasproperty              System.Management.Automation.PSAliasProperty
psvariableproperty           System.Management.Automation.PSVariableProperty
psnoteproperty               System.Management.Automation.PSNoteProperty
psscriptmethod               System.Management.Automation.PSScriptMethod
psscriptproperty             System.Management.Automation.PSScriptProperty
psvariable                   System.Management.Automation.PSVariable
CimSession                   Microsoft.Management.Infrastructure.CimSession
adsi                         System.DirectoryServices.DirectoryEntry
xml                          System.Xml.XmlDocument
X509Certificate              System.Security.Cryptography.X509Certificates.X509Certificate
X500DistinguishedName        System.Security.Cryptography.X509Certificates.X500DistinguishedName
adsisearcher                 System.DirectoryServices.DirectorySearcher
mailaddress                  System.Net.Mail.MailAddress
scriptblock                  System.Management.Automation.ScriptBlock
wmisearcher                  System.Management.ManagementObjectSearcher
wmiclass                     System.Management.ManagementClass
wmi                          System.Management.ManagementObject
single                       System.Single
guid                         System.Guid
float                        System.Single
double                       System.Double
DscResource                  System.Management.Automation.DscResourceAttribute
hashtable                    System.Collections.Hashtable
long                         System.Int64
int64                        System.Int64
int16                        System.Int16
int                          System.Int32
int32                        System.Int32
decimal                      System.Decimal
AllowNull                    System.Management.Automation.AllowNullAttribute
ArgumentCompleter            System.Management.Automation.ArgumentCompleterAttribute
AllowEmptyString             System.Management.Automation.AllowEmptyStringAttribute
Alias                        System.Management.Automation.AliasAttribute
AllowEmptyCollection         System.Management.Automation.AllowEmptyCollectionAttribute
array                        System.Array
CmdletBinding                System.Management.Automation.CmdletBindingAttribute
datetime                     System.DateTime
char                         System.Char
bool                         System.Boolean
byte                         System.Byte
ciminstance                  Microsoft.Management.Infrastructure.CimInstance
ref                          System.Management.Automation.PSReference
PSTypeNameAttribute          System.Management.Automation.PSTypeNameAttribute
psprimitivedictionary        System.Management.Automation.PSPrimitiveDictionary
psobject                     System.Management.Automation.PSObject
pscustomobject               System.Management.Automation.PSObject
regex                        System.Text.RegularExpressions.Regex
SupportsWildcards            System.Management.Automation.SupportsWildcardsAttribute
switch                       System.Management.Automation.SwitchParameter
string                       System.String
DscProperty                  System.Management.Automation.DscPropertyAttribute
sbyte                        System.SByte
pslistmodifier               System.Management.Automation.PSListModifier
IPEndpoint                   System.Net.IPEndPoint
NullString                   System.Management.Automation.Language.NullString
cimconverter                 Microsoft.Management.Infrastructure.CimConverter
cimclass                     Microsoft.Management.Infrastructure.CimClass
cimtype                      Microsoft.Management.Infrastructure.CimType
OutputType                   System.Management.Automation.OutputTypeAttribute
pscredential                 System.Management.Automation.PSCredential
PSDefaultValue               System.Management.Automation.PSDefaultValueAttribute
PhysicalAddress              System.Net.NetworkInformation.PhysicalAddress
ObjectSecurity               System.Security.AccessControl.ObjectSecurity
Parameter                    System.Management.Automation.ParameterAttribute
=========================================================================================
                          End Of Type And Accelerator Documentation
=========================================================================================
#>
#Requires -PSEdition Desktop
#Requires -Version 5.1
#Requires -Modules DISM
[CmdletBinding()]
param(
    [Parameter(HelpMessage="What operation do you want to do?")]
    [ValidateSet('Capture','Append','Mount','ExportWIM','ExportESD','RecompressWIM','RecompressESD','ConvertToWIM','ConvertToESD','GetInfo','Apply','SplitWIM','DeleteImage','ApplyAndDeleteImage','CreateISOWIM','CreateISOESD','ExtractWIM','ExtractESD','ExtractSWM','SaveWIM','SaveESD','SaveSWM','JoinWIM','JoinESD','ChangeBootIndexWIM','ChangeImageInfo','SetupProgram')]
    [string]$Op = 'SetupProgram',
    [Parameter(HelpMessage="Where is your image file or directory?")]
    [string]$Path = 'SetupProgram',
    [switch]$InstallingWindows,
    [Parameter(HelpMessage="Do you want to use the modern GUI? True or False value.")]
    [switch]$WPFUI,
    [switch]$NoHashes
)
# Adjust execution policy if script execution policy is not 'Bypass'.
if ((Get-ExecutionPolicy) -cne "Bypass") { Set-ExecutionPolicy Bypass -Scope Process -Force }
Import-Module DISM -Force
# Define the working directory. It will determine all the sub-locations.
$WorkingDir = $PSScriptRoot
Clear-Host
# Set a helpful message if you choose a resource-intensive operation.
$CompressWarn = "This will use all your system resources. It can take up to several hours depending on your system. Your cpu will remain at 100% usage."
# Check for administrator privelges.
$principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # Relaunch as administrator otherwise.
    # Ensure we build a relaunch command.
    $Relaunch_Arguments = @('-NoProfile','-NoLogo','-ExecutionPolicy','Bypass','-File',"`"$PSCommandPath`"",'-Op',$Op,'-Path',"`"$Path`"")
    if ($InstallingWindows) { $Relaunch_Arguments += "-InstallingWindows" } # If -InstallingWindows is passed, append that to our relaunch command.
    if ($NoHashes) { $Relaunch_Arguments += "-NoHashes" } # If NoHashes is passed, append that to our relaunch command.
    if ($WPFUI) { $Relaunch_Arguments += "-WPFUI" } # If WPFUI switch is passed, append that to our relaunch command.
    Start-Process PowerShell -ArgumentList $Relaunch_Arguments -Verb RunAs # Restart as administrator finally.
    Exit 2
}
[HashTable]$WindowsEditionIDs = @{
    # This is a list of literally ALL edition IDs for Windows Vista - Windows 11.
    # Windows XP and earlier are excluded because they do not use the WIM format.
    Client = @(
        "Ultimate"
        "UltimateN"
        "Business"
        "BusinessN"
        "Enterprise"
        "EnterpriseN"
        "EnterpriseE"
        "EnterpriseNEval"
        "EnterpriseEval"
        "Starter"
        "StarterN"
        "HomeBasic"
        "HomeBasicN"
        "HomePremium"
        "HomePremiumN"
        "Professional"
        "ProfessionalN"
        "ProfessionalE"
        "ProfessionalWMC"
        "Core"
        "CoreN"
        "CoreCountrySpecific"
        "CoreSingleLanguage"
        "CoreConnected"
        "CoreConnectedN"
        "CoreConnectedCountrySpecific"
        "CoreConnectedSingleLanguage"
        "CoreARM"
        "ProfessionalEducation"
        "ProfessionalEducationN"
        "ProfessionalWorkstation"
        "ProfessionalWorkstationN"
        "Education"
        "EducationN"
        "EnterpriseS"
        "EnterpriseSN"
        "EnterpriseSEval"
        "EnterpriseSNEval"
        "EnterpriseG"
        "EnterpriseGN"
        "EnterpriseGEval"
        "EnterpriseGNEval"
        "IoTEnterprise"
        "IoTEnterpriseK"
        "IoTEnterpriseS"
        "IoTEnterpriseSK"
        "ServerRdsh"
        "PPIPro"
        "CloudEdition"
        "CloudEditionN"
        "ProfessionalStudent"
        "ProfessionalStudentN"
    )
    # This is a list of literally ALL editions for Windows Server 2008 - Windows Server 2025.
    # Windows Server 2003 and earlier are excluded because they do not use the WIM format.
    Server = @(
        "ServerStandard"
        "ServerStandardEval"
        "ServerStandardCore"
        "ServerStandardCoreEval"
        "ServerStandardV"
        "ServerStandardACor"
        "ServerStandardNano"
        "ServerDatacenter"
        "ServerDatacenterEval"
        "ServerDatacenterCore"
        "ServerDatacenterCoreEval"
        "ServerDatacenterV"
        "ServerDatacenterACor"
        "ServerDatacenterNano"
        "ServerEnterprise"
        "ServerEnterpriseEval"
        "ServerEnterpriseCore"
        "ServerEnterpriseCoreEval"
        "ServerEnterpriseV"
        "ServerEnterpriseCoreV"
        "ServerWeb"
        "ServerWebEval"
        "ServerFoundation"
        "ServerEssentials"
        "ServerSolution"
        "ServerSolutionEval"
        "ServerSolutionEM"
        "ServerForSmallBusiness"
        "ServerForSmallBusinessV"
        "ServerForSBsolution"
        "ServerForSBsolutionEM"
        "ServerSmallBusiness"
        "ServerSmallBusinessPremium"
        "ServerSmallBusinessPremiumCore"
        "ServerStorageStandard"
        "ServerStorageStandardCore"
        "ServerStorageStandardEval"
        "ServerStorageWorkgroup"
        "ServerStorageWorkgroupCore"
        "ServerStorageWorkgroupEval"
        "ServerStorageEnterprise"
        "ServerStorageEnterpriseCore"
        "ServerStorageExpress"
        "ServerStorageExpressCore"
        "ServerStorageExpressEval"
        "ServerHyperV"
        "ServerHyperVCore"
        "ServerCloudStorage"
        "ServerAzureCor"
        "ServerTurbine"
        "ServerTurbineCor"
        "ServerAzureStackHCICor"
        "ServerARM64"
        "ServerDatacenterACor"
        "ServerStandardACor"
        "ServerDatacenterA"
        "ServerStandardA"
        "ServerDatacenterAServerCore"
        "ServerStandardAServerCore"
        "ClusterServer"
        "ClusterServerV"
        "HPCServer"
        "HPCServerV"
        "MultiPointStandardServer"
        "MultiPointPremiumServer"
        "SolutionEmbeddedServer"
        "MediumBusinessServerManagement"
        "MediumBusinessServerMessaging"
        "MediumBusinessServerSecurity"
    )
    # A list of banned edition ID's that will be blocked from use.
    # Primarily industrial editions.
    Banned = @(
        "IoTUAP"
        "IoTUAPCommercial"
        "EmbeddedIndustry"
        "EmbeddedIndustryE"
        "EmbeddedIndustryA"
        "EmbeddedIndustryEval"
        "EmbeddedIndustryEEval"
        "EmbeddedIndustryAEval"
        "MobileCore"
        "MobileEnterprise"
    )
}
if (($Op -ceq "SetupProgram") -and ($Path -ceq "SetupProgram")) {
    # Create an Affero GPL notice.
    $AGPLNotice = @'
===========================================================================
              Welcome To ALOS Image Tools By Aarav Katariya!
===========================================================================

Copyright (C) 2023-2026 Aarav Katariya

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

Wimlib-imagex.exe is licensed under the GNU General Public License version
3 or any later version. That is, for Windows builds. This program just calls
a compiled exe AS A SEPARATE PROCESS even though the code of wimlib-imagex can
be combined. Aarav Katariya chose not to combine them to avoid a combined work
which will have to be Affero GPL licensed (because AGPL is stricter than GPL).
'@
    # And then print it as well as a ten second delay.
    Write-Host $AGPLNotice -ForegroundColor Yellow # Ask me why I use 2023-20XX instead of just 20XX?
    Start-Sleep -Seconds 10
} else {
    # Show the operation to the user.
    Write-Host "Operation chosen: ${Op}`r`nFile or folder path selected: ${Path}.`r`n" # I hate LF line endings. I love CRLF endings.
}
# Add assemblies and types for GUI.
Add-Type -AssemblyName System.Windows.Forms, System.Drawing
if ($WPFUI) {
    Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase
    if ([System.Windows.Application]::Current -eq $null) {
        $app = [System.Windows.Application]::new()
        $app.ShutdownMode = [System.Windows.ShutdownMode]::OnExplicitShutdown
        $script:WpfApp = $app
    } else {
        $script:WpfApp = [System.Windows.Application]::Current
    }
}
# Enable visual styles for Windows Forms.
[System.Windows.Forms.Application]::EnableVisualStyles()
# Add the type for WIMGAPI use.
if (-not ('ALOSImageTools.NativeWimg' -as [type])) {
    $references = @(
        [System.Object].Assembly.Location
        [System.Runtime.InteropServices.Marshal].Assembly.Location
        [System.Xml.XmlDocument].Assembly.Location
    )
    Add-Type -ReferencedAssemblies $references -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
using System.Text;
using System.Xml;
namespace ALOSImageTools
{
    public static class NativeWimg
    {
        public const uint WIM_GENERIC_READ = 0x80000000;
        public const uint WIM_GENERIC_WRITE = 0x40000000;
        public const uint WIM_FLAG_SHARE_WRITE = 0x00000040;
        public const uint WIM_OPEN_EXISTING = 3;
        public const uint WIM_COMPRESS_NONE = 0;
        [StructLayout(
            LayoutKind.Sequential,
            CharSet = CharSet.Unicode)]
        public struct WIM_INFO
        {
            [MarshalAs(
                UnmanagedType.ByValTStr,
                SizeConst = 260)]
            public string WimPath;
            public Guid Guid;
            public uint ImageCount;
            public uint CompressionType;
            public ushort PartNumber;
            public ushort TotalParts;
            public uint BootIndex;
            public uint WimAttributes;
            public uint WimFlagsAndAttr;
        }
        [DllImport(
            "wimgapi.dll",
            CharSet = CharSet.Unicode,
            SetLastError = true,
            EntryPoint = "WIMCreateFile")]
        public static extern IntPtr WIMCreateFile(
            string pszWimPath,
            uint dwDesiredAccess,
            uint dwCreationDisposition,
            uint dwFlagsAndAttributes,
            uint dwCompressionType,
            out uint pdwCreationResult);
        [DllImport(
            "wimgapi.dll",
            SetLastError = true,
            EntryPoint = "WIMSetBootImage")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool WIMSetBootImage(
            IntPtr hWim,
            uint dwImageIndex);
        [DllImport(
            "wimgapi.dll",
            SetLastError = true,
            EntryPoint = "WIMGetAttributes")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool WIMGetAttributes(
            IntPtr hWim,
            out WIM_INFO pWimInfo,
            uint cbWimInfo);
        [DllImport(
            "wimgapi.dll",
            CharSet = CharSet.Unicode,
            SetLastError = true,
            EntryPoint = "WIMSetTemporaryPath")]
        [return: MarshalAs(UnmanagedType.Bool)]
        private static extern bool WIMSetTemporaryPath(
            IntPtr hWim,
            string pszPath);
        [DllImport(
            "wimgapi.dll",
            SetLastError = true,
            EntryPoint = "WIMLoadImage")]
        private static extern IntPtr WIMLoadImage(
            IntPtr hWim,
            uint dwImageIndex);
        [DllImport(
            "wimgapi.dll",
            SetLastError = true,
            EntryPoint = "WIMGetImageInformation")]
        [return: MarshalAs(UnmanagedType.Bool)]
        private static extern bool WIMGetImageInformation(
            IntPtr hImage,
            out IntPtr ppvImageInfo,
            out uint pcbImageInfo);
        [DllImport(
            "wimgapi.dll",
            SetLastError = true,
            EntryPoint = "WIMSetImageInformation")]
        [return: MarshalAs(UnmanagedType.Bool)]
        private static extern bool WIMSetImageInformation(
            IntPtr hImage,
            IntPtr pvImageInfo,
            uint cbImageInfo);
        [DllImport(
            "kernel32.dll",
            SetLastError = true,
            EntryPoint = "LocalFree")]
        private static extern IntPtr LocalFree(
            IntPtr hMem);
        [DllImport(
            "wimgapi.dll",
            SetLastError = true,
            EntryPoint = "WIMCloseHandle")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool WIMCloseHandle(
            IntPtr hObject);
        public static string GetImageInformation(
            IntPtr hImage)
        {
            IntPtr xmlBuffer = IntPtr.Zero;
            uint xmlSize = 0;
            if (!WIMGetImageInformation(
                hImage,
                out xmlBuffer,
                out xmlSize))
            {
                int lastError =
                    Marshal.GetLastWin32Error();
                throw new System.ComponentModel.Win32Exception(
                    lastError,
                    String.Format(
                        "WIMGetImageInformation failed with error {0}.",
                        lastError));
            }
            try
            {
                if (xmlBuffer == IntPtr.Zero)
                {
                    throw new InvalidOperationException(
                        "WIMGetImageInformation returned a null XML buffer.");
                }
                if (xmlSize == 0)
                {
                    throw new InvalidOperationException(
                        "WIMGetImageInformation returned an empty XML document.");
                }
                if ((xmlSize & 1) != 0)
                {
                    throw new InvalidOperationException(
                        String.Format(
                            "WIMGetImageInformation returned an invalid UTF-16 buffer size: {0} bytes.",
                            xmlSize));
                }
                int charCount =
                    checked((int)(xmlSize / 2));
                string xml =
                    Marshal.PtrToStringUni(
                        xmlBuffer,
                        charCount);
                if (xml == null)
                {
                    throw new InvalidOperationException(
                        "Unable to convert the WIM image-information buffer to a string.");
                }
                xml = xml.TrimEnd('\0');
                if (xml.Length > 0 &&
                    xml[0] == '\uFEFF')
                {
                    xml = xml.Substring(1);
                }
                if (String.IsNullOrWhiteSpace(xml))
                {
                    throw new InvalidOperationException(
                        "WIMGetImageInformation returned an empty XML document.");
                }
                return xml;
            }
            finally
            {
                if (xmlBuffer != IntPtr.Zero)
                {
                    LocalFree(xmlBuffer);
                }
            }
        }
        public static bool SetImageInformation(
            IntPtr hImage,
            string xml)
        {
            if (xml == null)
            {
                throw new ArgumentNullException("xml");
            }
            if (String.IsNullOrWhiteSpace(xml))
            {
                throw new ArgumentException(
                    "The XML document cannot be empty.",
                    "xml");
            }
            if (xml.Length == 0 ||
                xml[0] != '\uFEFF')
            {
                xml = "\uFEFF" + xml;
            }
            byte[] bytes =
                Encoding.Unicode.GetBytes(xml);
            if (bytes.Length == 0)
            {
                throw new InvalidOperationException(
                    "The XML document produced an empty byte buffer.");
            }
            IntPtr buffer =
                Marshal.AllocHGlobal(bytes.Length);
            try
            {
                Marshal.Copy(
                    bytes,
                    0,
                    buffer,
                    bytes.Length);
                bool result =
                    WIMSetImageInformation(
                        hImage,
                        buffer,
                        checked((uint)bytes.Length));
                if (!result)
                {
                    int lastError =
                        Marshal.GetLastWin32Error();
                    throw new System.ComponentModel.Win32Exception(
                        lastError,
                        String.Format(
                            "WIMSetImageInformation failed with error {0}.",
                            lastError));
                }
                return true;
            }
            finally
            {
                Marshal.FreeHGlobal(buffer);
            }
        }
        public static bool SetImageMetadata(
            IntPtr hWim,
            uint imageIndex,
            string name,
            string description,
            string flags,
            out string error)
        {
            error = null;
            IntPtr hImage = IntPtr.Zero;
            try
            {
                string tempPath =
                    System.IO.Path.Combine(
                        System.IO.Path.GetTempPath(),
                        "ALOSImageTools",
                        "WIM");
                System.IO.Directory.CreateDirectory(
                    tempPath);
                if (!WIMSetTemporaryPath(
                    hWim,
                    tempPath))
                {
                    int lastError =
                        Marshal.GetLastWin32Error();
                    error = String.Format(
                        "WIMSetTemporaryPath failed with error {0}.",
                        lastError);
                    return false;
                }
                hImage =
                    WIMLoadImage(
                        hWim,
                        imageIndex);
                if (hImage == IntPtr.Zero ||
                    hImage == new IntPtr(-1))
                {
                    int lastError =
                        Marshal.GetLastWin32Error();
                    error = String.Format(
                        "WIMLoadImage failed for image index {0}. WIMGAPI error {1}.",
                        imageIndex,
                        lastError);
                    return false;
                }
                string xml =
                    GetImageInformation(hImage);
                XmlDocument doc =
                    new XmlDocument();
                doc.PreserveWhitespace = true;
                doc.LoadXml(xml);
                XmlElement image =
                    doc.DocumentElement as XmlElement;
                if (image == null ||
                    !String.Equals(
                        image.Name,
                        "IMAGE",
                        StringComparison.Ordinal))
                {
                    error =
                        "WIMLoadImage returned invalid image-information XML.";
                    return false;
                }
                string actualIndex =
                    image.GetAttribute("INDEX");
                if (!String.Equals(
                        actualIndex,
                        imageIndex.ToString(),
                        StringComparison.Ordinal))
                {
                    error = String.Format(
                        "WIMLoadImage returned image index {0}, but image index {1} was requested.",
                        actualIndex,
                        imageIndex);
                    return false;
                }
                SetElementValue(
                    doc,
                    image,
                    "NAME",
                    name);
                SetElementValue(
                    doc,
                    image,
                    "DISPLAYNAME",
                    name);
                SetElementValue(
                    doc,
                    image,
                    "DESCRIPTION",
                    description);
                SetElementValue(
                    doc,
                    image,
                    "DISPLAYDESCRIPTION",
                    description);
                SetElementValue(
                    doc,
                    image,
                    "FLAGS",
                    flags);
                XmlNode verifyName =
                    image.SelectSingleNode("NAME");
                XmlNode verifyDisplayName =
                    image.SelectSingleNode("DISPLAYNAME");
                XmlNode verifyDescription =
                    image.SelectSingleNode("DESCRIPTION");
                XmlNode verifyDisplayDescription =
                    image.SelectSingleNode("DISPLAYDESCRIPTION");
                XmlNode verifyFlags =
                    image.SelectSingleNode("FLAGS");
                if (name != null)
                {
                    if (verifyName == null ||
                        !String.Equals(
                            verifyName.InnerText,
                            name,
                            StringComparison.Ordinal))
                    {
                        error = String.Format(
                            "Failed to update NAME before writing. Expected '{0}', actual '{1}'.",
                            name,
                            verifyName == null
                                ? "<missing>"
                                : verifyName.InnerText);
                        return false;
                    }
                    if (verifyDisplayName == null ||
                        !String.Equals(
                            verifyDisplayName.InnerText,
                            name,
                            StringComparison.Ordinal))
                    {
                        error = String.Format(
                            "Failed to update DISPLAYNAME before writing. Expected '{0}', actual '{1}'.",
                            name,
                            verifyDisplayName == null
                                ? "<missing>"
                                : verifyDisplayName.InnerText);
                        return false;
                    }
                }
                if (description != null)
                {
                    if (verifyDescription == null ||
                        !String.Equals(
                            verifyDescription.InnerText,
                            description,
                            StringComparison.Ordinal))
                    {
                        error = String.Format(
                            "Failed to update DESCRIPTION before writing. Expected '{0}', actual '{1}'.",
                            description,
                            verifyDescription == null
                                ? "<missing>"
                                : verifyDescription.InnerText);
                        return false;
                    }
                    if (verifyDisplayDescription == null ||
                        !String.Equals(
                            verifyDisplayDescription.InnerText,
                            description,
                            StringComparison.Ordinal))
                    {
                        error = String.Format(
                            "Failed to update DISPLAYDESCRIPTION before writing. Expected '{0}', actual '{1}'.",
                            description,
                            verifyDisplayDescription == null
                                ? "<missing>"
                                : verifyDisplayDescription.InnerText);
                        return false;
                    }
                }
                if (flags != null)
                {
                    if (verifyFlags == null ||
                        !String.Equals(
                            verifyFlags.InnerText,
                            flags,
                            StringComparison.Ordinal))
                    {
                        error = String.Format(
                            "Failed to update FLAGS before writing. Expected '{0}', actual '{1}'.",
                            flags,
                            verifyFlags == null
                                ? "<missing>"
                                : verifyFlags.InnerText);
                        return false;
                    }
                }
                return SetImageInformation(
                    hImage,
                    doc.OuterXml);
            }
            catch (Exception ex)
            {
                error = ex.Message;
                return false;
            }
            finally
            {
                if (hImage != IntPtr.Zero &&
                    hImage != new IntPtr(-1))
                {
                    WIMCloseHandle(hImage);
                }
            }
        }
        private static void SetElementValue(
            XmlDocument document,
            XmlNode image,
            string elementName,
            string value)
        {
            if (value == null)
            {
                return;
            }
            XmlNode node =
                image.SelectSingleNode(
                    elementName);
            if (node == null)
            {
                node =
                    document.CreateElement(
                        elementName);
                image.AppendChild(node);
            }
            node.InnerText = value;
        }
    }
}
'@
}
function Question {
    param(
        [Parameter(Mandatory)]
        [string]$msg,
        [System.Windows.Forms.MessageBoxButtons]$Buttons = [System.Windows.Forms.MessageBoxButtons]::YesNo,
        [System.Windows.Forms.MessageBoxIcon]$Icon = [System.Windows.Forms.MessageBoxIcon]::Question
    )
    if ($WPFUI) {
        $Buttons = @{
            'Yes' = [System.Windows.MessageBoxResult]::Yes
            'No' = [System.Windows.MessageBoxResult]::No
            'OK' = [System.Windows.MessageBoxResult]::OK
            'Cancel' = [System.Windows.MessageBoxResult]::Cancel
        }
        $WPFButtons = switch ($Buttons) {
            ([System.Windows.Forms.MessageBoxButtons]::YesNo) { [System.Windows.MessageBoxButton]::YesNo }
            ([System.Windows.Forms.MessageBoxButtons]::YesNoCancel) { [System.Windows.MessageBoxButton]::YesNoCancel }
            ([System.Windows.Forms.MessageBoxButtons]::OKCancel) { [System.Windows.MessageBoxButton]::OKCancel }
            default { [System.Windows.MessageBoxButton]::OK }
        }
        $WPFIcon = switch ($Icon) {
            ([System.Windows.Forms.MessageBoxIcon]::Question) { [System.Windows.MessageBoxImage]::Question }
            ([System.Windows.Forms.MessageBoxIcon]::Error) { [System.Windows.MessageBoxImage]::Error }
            ([System.Windows.Forms.MessageBoxIcon]::Warning) { [System.Windows.MessageBoxImage]::Warning }
            default { [System.Windows.MessageBoxImage]::Information }
        }
        $Result = [System.Windows.MessageBox]::Show($msg, 'ALOS Image Tools', $WPFButtons, $WPFIcon)
        switch ($Result) {
            ([System.Windows.MessageBoxResult]::Yes) { return [System.Windows.Forms.DialogResult]::Yes }
            ([System.Windows.MessageBoxResult]::No) { return [System.Windows.Forms.DialogResult]::No }
            ([System.Windows.MessageBoxResult]::OK) { return [System.Windows.Forms.DialogResult]::OK }
            ([System.Windows.MessageBoxResult]::Cancel) { return [System.Windows.Forms.DialogResult]::Cancel }
            default { return [System.Windows.Forms.DialogResult]::None }
        }
    } else {
        return [System.Windows.Forms.MessageBox]::Show($msg, 'ALOS Image Tools', $Buttons, $Icon)
    }
}
# Function to show error message and exit.
function Error($msg) {
    $Host.UI.RawUI.WindowTitle = "$Op Failed On $Path" # Set the Window Title to say failed.
    if ($WPFUI) { [System.Windows.MessageBox]::Show($msg, 'ALOS Image Tools', [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error) | Out-Null } else { [System.Windows.Forms.MessageBox]::Show($msg, 'ALOS Image Tools', [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error) | Out-Null }
    exit 1
}
# Function to show warning message.
function Warn($msg) { if ($WPFUI) { [System.Windows.MessageBox]::Show($msg, 'ALOS Image Tools', [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Warning) | Out-Null } else { [System.Windows.Forms.MessageBox]::Show($msg, 'ALOS Image Tools', [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning) | Out-Null } }
# Function to show information message.
function Info($msg) { if ($WPFUI) { [System.Windows.MessageBox]::Show($msg, 'ALOS Image Tools', [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Information) | Out-Null } else { [System.Windows.Forms.MessageBox]::Show($msg, 'ALOS Image Tools', [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information) | Out-Null } }
# Function to set-progress. It depends on the Write-Progress cmdlet!
function Set-Progress {
    param(
        [Parameter(Mandatory)]
        [string]$Activity,
        [Parameter(Mandatory)]
        [string]$Status,
        [Parameter(Mandatory)]
        [int]$PercentComplete,
        [Parameter(Mandatory=$false)]
        [uint16]$ProgID = 1
    )
    # Clamp values to between 0 and 100.
    if ($PercentComplete -lt 0) { $PercentComplete = 0 } # Ensure no values below 0.
    if ($PercentComplete -gt 100) { $PercentComplete = 100 } # Ensure no values above 100.
    # Then write that progress.
    Write-Progress -Id $ProgID -Activity $Activity -Status $Status -PercentComplete $PercentComplete
}
# Function to complete the progress from Set-Progress.
function Complete-Progress {
    param(
        [Parameter(Mandatory)]
        [string]$Activity,
        [Parameter(Mandatory=$false)]
        [uint16]$ProgID = 1
    )
    Write-Progress -Id $ProgID -Activity $Activity -Status "Completed" -PercentComplete 100 -Completed
}
# Create a dark mode function that blacks out the windows of Windows Forms GUI's.
function Enable-DarkMode {
    param([System.Windows.Forms.Control]$ControlRoot)
    $colorBack = [System.Drawing.Color]::FromArgb(0,0,0)
    $colorPanel = [System.Drawing.Color]::FromArgb(0,0,0)
    $colorAltPanel = [System.Drawing.Color]::FromArgb(0,0,0)
    $colorText = [System.Drawing.Color]::FromArgb(255,255,255)
    $colorButton = [System.Drawing.Color]::FromArgb(0,0,0)
    $colorBorder = [System.Drawing.Color]::FromArgb(255,255,255)
    $colorHighlight = [System.Drawing.Color]::FromArgb(0,0,0)
    if (-not $ControlRoot) { return }
    try {
        if ($ControlRoot -is [System.Windows.Forms.Form]) {
            try { $ControlRoot.BackColor = $colorBack } catch {}
            try { $ControlRoot.ForeColor = $colorText } catch {}
            if ($ControlRoot.Font -eq $null) { $ControlRoot.Font = New-Object System.Drawing.Font("Segoe UI",9) }
            try { $ControlRoot.Padding = [System.Windows.Forms.Padding]::new(6) } catch {}
        } else {
            try { $ControlRoot.BackColor = $colorBack } catch {}
            try { $ControlRoot.ForeColor = $colorText } catch {}
            try { if ($ControlRoot.Font -eq $null) { $ControlRoot.Font = New-Object System.Drawing.Font("Segoe UI",9) } } catch {}
        }
    } catch {}
    # Define a sub-function to set the control theme.
    function Set-DarkTheme {
        param($ctrl)
        if ($null -eq $ctrl) { return }
        try {
            if ($ctrl -is [System.Windows.Forms.Button]) {
                $ctrl.BackColor = $colorButton
                $ctrl.ForeColor = $colorText
                $ctrl.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
                try { $ctrl.FlatAppearance.BorderColor = $colorBorder } catch {}
                try { $ctrl.Font = New-Object System.Drawing.Font($ctrl.Font.FontFamily, $ctrl.Font.Size) } catch {}
            }
            elseif ($ctrl -is [System.Windows.Forms.Label]) {
                $ctrl.ForeColor = $colorText
                try { $ctrl.BackColor = 'Transparent' } catch {}
            }
            elseif ($ctrl -is [System.Windows.Forms.Panel] -or $ctrl -is [System.Windows.Forms.GroupBox]) {
                $ctrl.BackColor = $colorPanel
                $ctrl.ForeColor = $colorText
            }
            elseif ($ctrl -is [System.Windows.Forms.ListBox]) {
                $ctrl.BackColor = $colorAltPanel
                $ctrl.ForeColor = $colorText
                try { $ctrl.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle } catch {}
            }
            elseif ($ctrl -is [System.Windows.Forms.TextBox]) {
                $ctrl.BackColor = $colorAltPanel
                $ctrl.ForeColor = $colorText
                try { $ctrl.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle } catch {}
            }
            elseif ($ctrl -is [System.Windows.Forms.RichTextBox]) {
                $ctrl.BackColor = $colorAltPanel
                $ctrl.ForeColor = $colorText
            }
            elseif ($ctrl -is [System.Windows.Forms.NumericUpDown] -or $ctrl -is [System.Windows.Forms.ComboBox]) {
                $ctrl.BackColor = $colorAltPanel
                $ctrl.ForeColor = $colorText
            }
            elseif ($ctrl -is [System.Windows.Forms.CheckBox] -or $ctrl -is [System.Windows.Forms.RadioButton]) {
                $ctrl.ForeColor = $colorText
                try { $ctrl.BackColor = 'Transparent' } catch {}
            }
            elseif ($ctrl -is [System.Windows.Forms.DataGridView]) {
                $ctrl.BackgroundColor = $colorPanel
                try {
                    $ctrl.DefaultCellStyle.BackColor = $colorAltPanel
                    $ctrl.DefaultCellStyle.ForeColor = $colorText
                    $ctrl.GridColor = $colorBorder
                } catch {}
                try { $ctrl.ColumnHeadersDefaultCellStyle.BackColor = $colorPanel } catch {}
                try { $ctrl.ColumnHeadersDefaultCellStyle.ForeColor = $colorText } catch {}
            }
            elseif ($ctrl -is [System.Windows.Forms.ListView]) {
                $ctrl.BackColor = $colorAltPanel
                $ctrl.ForeColor = $colorText
            }
            elseif ($ctrl -is [System.Windows.Forms.ToolStrip]) {
                $ctrl.BackColor = $colorPanel
                foreach ($item in $ctrl.Items) {
                    try { $item.ForeColor = $colorText } catch {}
                    try { if ($item -is [System.Windows.Forms.ToolStripButton] -or $item -is [System.Windows.Forms.ToolStripLabel]) { $item.BackColor = $colorPanel } } catch {}
                }
            }
            else {
                try { $ctrl.BackColor = $colorAltPanel } catch {}
                try { $ctrl.ForeColor = $colorText } catch {}
            }
        } catch {}
        foreach ($child in @($ctrl.Controls)) { Set-DarkTheme $child }
        try {
            if ($ctrl -is [System.Windows.Forms.ToolStripContainer]) {
                foreach ($ts in @($ctrl.TopToolStripPanel.Controls)) { Set-DarkTheme $ts }
                foreach ($ts in @($ctrl.BottomToolStripPanel.Controls)) { Set-DarkTheme $ts }
                foreach ($ts in @($ctrl.LeftToolStripPanel.Controls)) { Set-DarkTheme $ts }
                foreach ($ts in @($ctrl.RightToolStripPanel.Controls)) { Set-DarkTheme $ts }
            }
        } catch {}
    }
    Set-DarkTheme $ControlRoot
}
# Function to pick a folder.
function Pick-Folder($title, $default) {
    if ($WPFUI) {
        if (-not ("WPF_FolderBrowser" -as [type])) {
            Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public static class WPF_FolderBrowser
{
    [ComImport]
    [Guid("DC1C5A9C-E88A-4DDE-A5A1-60F82A20AEF7")]
    private class FileOpenDialog
    {
    }
    [ComImport]
    [Guid("42F85136-DB7E-439C-85F1-E4075D135FC8")]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    private interface IFileDialog
    {
        [PreserveSig]
        int Show(IntPtr parent);
        void SetFileTypes(
            uint count,
            IntPtr filters);
        void SetFileTypeIndex(
            uint index);
        void GetFileTypeIndex(
            out uint index);
        void Advise(
            IntPtr events,
            out uint cookie);
        void Unadvise(
            uint cookie);
        void SetOptions(
            uint options);
        void GetOptions(
            out uint options);
        void SetDefaultFolder(
            IShellItem item);
        void SetFolder(
            IShellItem item);
        void GetFolder(
            out IShellItem item);
        void GetCurrentSelection(
            out IShellItem item);
        void SetFileName(
            [MarshalAs(UnmanagedType.LPWStr)]
            string name);
        void GetFileName(
            [MarshalAs(UnmanagedType.LPWStr)]
            out string name);
        void SetTitle(
            [MarshalAs(UnmanagedType.LPWStr)]
            string title);
        void SetOkButtonLabel(
            [MarshalAs(UnmanagedType.LPWStr)]
            string text);
        void SetFileNameLabel(
            [MarshalAs(UnmanagedType.LPWStr)]
            string text);
        void GetResult(
            out IShellItem item);
        void AddPlace(
            IShellItem item,
            int placement);
        void SetDefaultExtension(
            [MarshalAs(UnmanagedType.LPWStr)]
            string extension);
        void Close(
            int hr);
        void SetClientGuid(
            ref Guid guid);
        void ClearClientData();
        void SetFilter(
            IntPtr filter);
    }
    [ComImport]
    [Guid("43826D1E-E718-42EE-BC55-A1E261C37BFE")]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    private interface IShellItem
    {
        void BindToHandler(
            IntPtr pbc,
            ref Guid bhid,
            ref Guid riid,
            out IntPtr ppv);
        void GetParent(
            out IShellItem parent);
        void GetDisplayName(
            uint sigdnName,
            [MarshalAs(UnmanagedType.LPWStr)]
            out string name);
        void GetAttributes(
            uint sfgaoMask,
            out uint sfgaoAttribs);
        void Compare(
            IShellItem psi,
            uint hint,
            out int order);
    }
    [DllImport(
        "shell32.dll",
        CharSet = CharSet.Unicode,
        PreserveSig = true)]
    private static extern int SHCreateItemFromParsingName(
        string pszPath,
        IntPtr pbc,
        ref Guid riid,
        out IShellItem ppv);
    private const uint FOS_PICKFOLDERS = 0x00000020;
    private const uint FOS_FORCEFILESYSTEM = 0x00000040;
    private const uint SIGDN_FILESYSPATH = 0x80058000;
    private static Guid IID_IShellItem =
        new Guid("43826D1E-E718-42EE-BC55-A1E261C37BFE");
    public static string PickFolder(
        string title,
        string defaultPath)
    {
        IFileDialog dialog =
            (IFileDialog)new FileOpenDialog();
        uint options;
        dialog.GetOptions(out options);
        options |= FOS_PICKFOLDERS;
        options |= FOS_FORCEFILESYSTEM;
        dialog.SetOptions(options);
        if (!string.IsNullOrWhiteSpace(title))
        {
            dialog.SetTitle(title);
        }
        if (!string.IsNullOrWhiteSpace(defaultPath) &&
            System.IO.Directory.Exists(defaultPath))
        {
            IShellItem folder;
            int hr = SHCreateItemFromParsingName(
                defaultPath,
                IntPtr.Zero,
                ref IID_IShellItem,
                out folder);
            if (hr >= 0 && folder != null)
            {
                dialog.SetFolder(folder);
            }
        }
        int result = dialog.Show(IntPtr.Zero);
        if (result == unchecked((int)0x800704C7))
        {
            return null;
        }
        if (result < 0)
        {
            Marshal.ThrowExceptionForHR(result);
        }
        IShellItem selected;
        dialog.GetResult(out selected);
        string path;
        selected.GetDisplayName(
            SIGDN_FILESYSPATH,
            out path);
        return path;
    }
}
"@
        }
        $result = [WPF_FolderBrowser]::PickFolder($title, $default)
        if ($result -and (Test-Path -LiteralPath $result -PathType Container)) { return $result }
        Error "Operation cancelled."
    } else {
        $dlg = New-Object System.Windows.Forms.FolderBrowserDialog
        $dlg.Description = $title
        if ($default -and (Test-Path $default)) { $dlg.SelectedPath = $default }
        if ($dlg.ShowDialog() -eq 'OK') { return $dlg.SelectedPath }
        Error "Operation cancelled."
    }
}
# Function to pick a location for saving a file.
function Pick-SaveFile($filter, $DefaultName) {
    if ($WPFUI) {
        $dlg = New-Object Microsoft.Win32.SaveFileDialog
        $dlg.Filter = $filter
        if ($DefaultName) { $dlg.FileName = $DefaultName }
        if ($dlg.ShowDialog()) { Clear-Host; return $dlg.FileName }
        if ($Op -eq 'SaveWIM') { Info "Then you can append to a wimfile instead." } else { Error "Operation cancelled." }
    } else {
        $dlg = New-Object System.Windows.Forms.SaveFileDialog
        $dlg.Filter = $filter
        if ($DefaultName) { $dlg.FileName = $DefaultName }
        if ($dlg.ShowDialog() -eq 'OK') { Clear-Host; return $dlg.FileName }
        if ($Op -eq 'SaveWIM') { Info "Then you can append to a wimfile instead." } else { Error "Operation cancelled." }
    }
}
# Function to pick a file to open/select.
function Pick-OpenFile($filter, $default) {
    if ($WPFUI) {
        $dlg = New-Object Microsoft.Win32.OpenFileDialog
        $dlg.Filter = $filter
        if ($default) { $dlg.FileName = $default }
        if ($dlg.ShowDialog()) { Clear-Host; return $dlg.FileName }
        Error "Operation cancelled."
    } else {
        $dlg = New-Object System.Windows.Forms.OpenFileDialog
        $dlg.Filter = $filter
        if ($dlg.ShowDialog() -eq 'OK') { Clear-Host; return $dlg.FileName }
        Error "Operation cancelled."
    }
}
# Function to pick an index.
function Pick-Index {
    param (
        [Parameter(Mandatory)]
        [string]$Path,
        [switch]$MultipleImages
    )
    $raw = & $wimlib info $Path 2>&1
    if ($LASTEXITCODE -ne 0) { Error "Failed to get image info.`n$raw" }
    $entries = @()
    $current = $null
    foreach ($line in $raw -split "`r?`n") {
        if ($line -match '^\s*Index\s*:\s*(\d+)') {
            $current = [PSCustomObject]@{
                Index = [int]$matches[1]
                Name  = ''
            }
            $entries += $current
        }
        elseif ($current -and $line -match '^\s*Name\s*:\s*(.+)') { $current.Name = $matches[1].Trim() }
    }
    if (-not $entries) { Error "No images found in:`n$Path" }
    if (-not $MultipleImages -and $entries.Count -eq 1) { return [int]$entries[0].Index }
    $form = New-Object Windows.Forms.Form
    $form.Text = if ($MultipleImages) { "Select one or more image indices using Ctrl+Click." } else { "Select an image index" }
    $form.Width = 800
    $form.Height = 600
    $form.StartPosition = 'CenterScreen'
    $form.MinimizeBox = $false
    $form.MaximizeBox = $false
    $form.FormBorderStyle = 'FixedDialog'
    $form.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::Dpi
    $form.Padding = '8,8,8,8'
    $form.Font = New-Object System.Drawing.Font("Segoe UI", 9)
    $ThemeControl = Is-LightModeOn
    if ($ThemeControl.Apps -or $ThemeControl.System) { Enable-DarkMode $form }
    $lbl = New-Object Windows.Forms.Label
    $lbl.Text = if ($MultipleImages) { "Select one or more image indices using Ctrl+Click." }
    else { "Select an image index" }
    $lbl.AutoSize = $true
    $lbl.Dock = 'Bottom'
    $lbl.Padding = '4,4,4,6'
    $lbl.Font = New-Object System.Drawing.Font("Segoe UI", 9.5, [System.Drawing.FontStyle]::Bold)
    $lbl.ForeColor = $form.ForeColor
    $lbl.BackColor = 'Transparent'
    $list = New-Object Windows.Forms.ListBox
    $list.Dock = 'Fill'
    $list.IntegralHeight = $false
    $list.SelectionMode = if ($MultipleImages) { [System.Windows.Forms.SelectionMode]::MultiExtended } else { [System.Windows.Forms.SelectionMode]::One }
    $list.Font = New-Object System.Drawing.Font("Segoe UI", 9)
    foreach ($img in $entries) {
        $label = "Index $($img.Index)"
        if ($img.Name) { $label += " --- $($img.Name)" }
        $list.Items.Add($label) | Out-Null
    }
    $panel = New-Object Windows.Forms.Panel
    $panel.Dock = 'Bottom'
    $panel.Height = 46
    $panel.Padding = '6,6,6,6'
    $panel.BackColor = $form.BackColor
    $IsExportOperation = $Op -in @('ExportWIM', 'ExportESD')
    if ($IsExportOperation) {
        $ExportAll = New-Object Windows.Forms.Button
        $ExportAll.Text = 'Export All'
        $ExportAll.Width = 100
        $ExportAll.Height = 28
        $ExportAll.Anchor = 'Right,Bottom'
    }
    $ok = New-Object Windows.Forms.Button
    $ok.Text = 'Proceed'
    $ok.Width = 90
    $ok.Height = 28
    $ok.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $ok.Anchor = 'Right,Bottom'
    $cancel = New-Object Windows.Forms.Button
    $cancel.Text = 'Abort'
    $cancel.Width = 90
    $cancel.Height = 28
    $cancel.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $cancel.Anchor = 'Right,Bottom'
    $panel.Controls.Add($cancel)
    if ($IsExportOperation) { $panel.Controls.Add($ExportAll) }
    $panel.Controls.Add($ok)
    $form.AcceptButton = $ok
    $form.CancelButton = $cancel
    $ThemeControl = Is-LightModeOn
    if ($ThemeControl.Apps) {
        Enable-DarkMode $panel
        Enable-DarkMode $list
        Enable-DarkMode $ok
        Enable-DarkMode $cancel
        Enable-DarkMode $lbl
        if ($IsExportOperation) { Enable-DarkMode $ExportAll }
    }
    if ($IsExportOperation) {
        $script:ExportAllChosen = $false
        $ExportAll.Add_Click({
            $script:ExportAllChosen = $true
            $form.DialogResult = [System.Windows.Forms.DialogResult]::OK
            $form.Close()
        })
    }
    else { $script:ExportAllChosen = $false }
    $panel.Add_Resize({
        param($s, $e)
        $p = $s
        $spacing = 8
        $cancel.Left = $p.ClientSize.Width - $cancel.Width - 6
        $cancel.Top = 8
        if ($IsExportOperation) {
            $ExportAll.Left = $cancel.Left - $ExportAll.Width - $spacing
            $ExportAll.Top = 8
            $ok.Left = $ExportAll.Left - $ok.Width - $spacing
        }
        else { $ok.Left = $cancel.Left - $ok.Width - $spacing }
        $ok.Top = 8
    })
    $list.Add_DoubleClick({
        if ($list.SelectedIndex -ge 0) {
            $form.DialogResult = [System.Windows.Forms.DialogResult]::OK
            $form.Close()
        }
    })
    $form.Controls.Add($lbl)
    $form.Controls.Add($panel)
    $form.Controls.Add($list)
    $panel.PerformLayout()
    $panel.Refresh()
    $spacing = 8
    $cancel.Left = $panel.ClientSize.Width - $cancel.Width - 6
    $cancel.Top = 8
    if ($IsExportOperation) {
        $ExportAll.Left = $cancel.Left - $ExportAll.Width - $spacing
        $ExportAll.Top = 8
        $ok.Left = $ExportAll.Left - $ok.Width - $spacing
    }
    else { $ok.Left = $cancel.Left - $ok.Width - $spacing }
    $ok.Top = 8
    $res = $form.ShowDialog()
    if ($res -ne [System.Windows.Forms.DialogResult]::OK) { Error "No index selected." }
    if ($IsExportOperation -and $script:ExportAllChosen) { return @($entries | ForEach-Object { [int]$_.Index }) }
    if ($MultipleImages) {
        $sel = @()
        foreach ($i in $list.SelectedIndices) { $sel += $entries[$i].Index }
        if (-not $sel) { Error "No index selected." }
        return ,$sel
    }
    else {
        if ($list.SelectedIndex -lt 0) { Error "No index selected." }
        return [int]$entries[$list.SelectedIndex].Index
    }
}
# Function to calculate the CRC32 or CRC64 hash. It depends on 7-Zip console though. I could not implement CRC myself!
function Get-CRC {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path,
        [Parameter(Mandatory=$true)]
        [ValidateSet('CRC32','CRC64')]
        [string]$Algorithm
    )
    $sevenz = "$WorkingDir\bin\7z.exe"
    if ($Algorithm -eq 'CRC32') {
        $args = @('h','-scrcCRC32',$Path)
        $expectedLen = 8
        $label = 'CRC32'
    } elseif ($Algorithm -eq 'CRC64') {
        $args = @('h','-scrcCRC64',$Path)
        $expectedLen = 16
        $label = 'CRC64'
    } else {
        return
    }
    $raw = & "$sevenz" @args 2>&1
    $exit = $LASTEXITCODE
    if ($exit -ne 0) { Error "An error occurred getting the CRC hash. (${exit})`r`nOutput:`r`n$raw" }
    $hash = $null
    $lines = $raw -split "`r?`n"
    # Regex matching.
    foreach ($line in $lines) {
        if ($line -match "$label\s+for data:\s*([0-9A-Fa-f]+)") {
            $hash = $matches[1]
            break
        }
        # More regex matching.
        if ($line -match '^\s*([0-9A-Fa-f]{8,16})\s+\d+\s+\S+') {
            $cand = $matches[1]
            if ($cand.Length -eq $expectedLen) {
                $hash = $cand
                break
            }
        }
    }
    if (-not $hash) {
        $m = [regex]::Match($raw, "([0-9A-Fa-f]{$expectedLen})")
        if ($m.Success) { $hash = $m.Groups[1].Value }
    }
    if (-not $hash) { Error "Errored to parse $label from output.`nOutput:`n$raw" }
    return $hash.ToUpper()
}
# [SPECIAL] Function to mimick Coalesce from PowerShell 7.
function Coalesce {
    param(
        [Parameter(Mandatory=$true, ValueFromRemainingArguments=$true)]
        [object[]]$Values
    )
    foreach ($v in $Values) {
        if ($null -ne $v) {
            if ($v -is [string]) {
                if ($v -ne '') { return $v }
            } else {
                return $v
            }
        }
    }
    return $null
}
# Function to check if light mode active. Needed to decide if Dark Mode should be enabled.
function Is-LightModeOn {
    $BasePath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize'
    # Create a sub-function to run.
    function Get-Flag {
        param(
            [string]$Path,
            [string]$Name
        )
        try {
            $raw = Get-ItemPropertyValue -Path $Path -Name $Name -ErrorAction Stop
        } catch {
            Write-Host "Registry value '$Name' not found at '$Path'."
            return $false
        }
        try {
            [int]$val = $raw
        } catch {
            if ([int]::TryParse([string]$raw,[ref]$null)) {
                [int]$val = [int]$raw
            } else {
                Write-Verbose "Could not convert registry value '$Name' ('$raw') to int." -Verbose
                return $false
            }
        }
        return ($val -eq 0)
    }
    $Apps = Get-Flag -Path $BasePath -Name 'AppsUseLightTheme'
    $System = Get-Flag -Path $BasePath -Name 'SystemUsesLightTheme'
    return [PSCustomObject]@{
        Apps = $Apps
        System = $System
    }
}
# Function to safely quote a single command-line argument.
function Quote-Arg {
    param([Parameter(Mandatory)][string]$Arg)
    if ($Arg -eq '') { return '""' }
    $escaped = $Arg -replace '"','\"'
    if ($escaped -match '\s|["]') {
        return '"' + $escaped + '"'
    } else {
        return $escaped
    }
}
# Function to locate an executable from common candidates or PATH.
function Find-Executable {
    param(
        [Parameter(Mandatory)]
        [string[]]$Candidates
    )
    foreach ($c in $Candidates) {
        try {
            $cmd = Get-Command $c -ErrorAction SilentlyContinue
            if ($cmd) { return $cmd.Source }
        } catch {}
        if (Test-Path $c) { return (Resolve-Path -LiteralPath $c).Path }
        if ([IO.Path]::IsPathRooted($c) -eq $false -and $c -match '\.exe$') {
            $tryPf = Join-Path $env:ProgramFiles $c
            if (Test-Path $tryPf) { return (Resolve-Path -LiteralPath $tryPf).Path }
            $tryPf2 = Join-Path $WorkingDir "bin\$c"
            if (Test-Path $tryPf2) { return (Resolve-Path -LiteralPath $tryPf2).Path }
        }
    }
    return $null
}
# Function to validate if the user selected the root of the drive.
function Test-Root {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$Path
    )
    if ($Path -like '\\*') { Error "Network/UNC paths are not allowed. Please select a local drive root (e.g. D:\)." } # Reject UNC paths.
    $SystemDrive = $env:SYSTEMDRIVE.TrimEnd('\')
    # And prevent selecting the system drive.
    if ($Path.TrimEnd('\') -ieq $SystemDrive) { Error "I am sorry. You may not install Windows here as this can wreck your computer system. + Windows is already installed on this drive." }
    try {
        $resolved = (Get-Item -LiteralPath $Path -ErrorAction Stop).FullName
    } catch {
        try {
            $resolved = Convert-Path -LiteralPath $Path -ErrorAction Stop
        } catch {
            return [PSCustomObject]@{
                Path = $Path
                Resolved = $null
                IsRoot = $false
                Root = $null
                FileSystem = $null
                IsNTFS = $false
                Error = "Path does not exist or cannot be resolved: $Path"
            }
        }
    }
    $root = [IO.Path]::GetPathRoot($resolved)
    $isRoot = ($resolved.TrimEnd('\') -eq $root.TrimEnd('\'))
    $fs = $null
    $driveType = $null
    try {
        $vol = Get-Volume -Path $resolved -ErrorAction Stop
        $fs = $vol.FileSystem
        if ($root -and $root.Length -ge 2 -and $root.Substring(1,1) -eq ':') {
            $deviceId = $root.Substring(0,2)
            try {
                $ld = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='$deviceId'" -ErrorAction Stop
                $driveType = [int]$ld.DriveType
            } catch {
                $driveType = $null
            }
        }
    } catch {
        try {
            if ($root -and $root.Length -ge 2 -and $root.Substring(1,1) -eq ':') {
                $deviceId = $root.Substring(0,2)
                $ld = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='$deviceId'" -ErrorAction Stop
                $fs = $ld.FileSystem
                $driveType = [int]$ld.DriveType
            } else {
                $fs = $null
                $driveType = $null
            }
        } catch {
            Error "I think something wrong happened on our end..."
        }
    }
    if ($driveType -eq 4 -or $driveType -eq 5 -or $driveType -eq 6) { Error "You have picked a banned drive. This cannot be used." }
    if (-not $fs) {
        return [PSCustomObject]@{
            Path = $Path
            Resolved = $resolved
            IsRoot = $isRoot
            Root = $root
            FileSystem = $null
            IsNTFS = $false
            Error = "Unable to determine filesystem for selected path. Network/UNC or unsupported mountpoints are not allowed."
        }
    }
    $isNtfs = $false
    if ($fs) { $isNtfs = ($fs -ieq 'NTFS') }
    return [PSCustomObject]@{
        Path = $Path
        Resolved = $resolved
        IsRoot = $isRoot
        Root = $root
        FileSystem = $fs
        IsNTFS = $isNtfs
        Error = $null
    }
}
# Function to get dark theme resource dictionary for WPF
function Get-WpfDarkTheme {
    $dict = New-Object System.Windows.ResourceDictionary
    $dict.Add("BackgroundBrush", [System.Windows.Media.Brushes]::Black)
    $dict.Add("ForegroundBrush", [System.Windows.Media.Brushes]::White)
    $dict.Add("PanelBackground", [System.Windows.Media.Brushes]::Black)
    $dict.Add("AltBackground", [System.Windows.Media.Brushes]::Black)
    $dict.Add("BorderBrush", [System.Windows.Media.Brushes]::White)
    $dict.Add("ControlBackground", [System.Windows.Media.Brushes]::Black)
    $dict.Add("ControlForeground", [System.Windows.Media.Brushes]::White)
    $dict.Add("ButtonBackground", [System.Windows.Media.Brushes]::Black)
    $dict.Add("ButtonForeground", [System.Windows.Media.Brushes]::White)
    $dict.Add("ListBoxBackground", [System.Windows.Media.Brushes]::Black)
    $dict.Add("ListBoxForeground", [System.Windows.Media.Brushes]::White)
    return $dict
}
# Apply dark theme to the application if light mode is not active
function Test-WpfLightMode {
    $BasePath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize'
    function Get-Flag($Name) {
        try {
            $val = Get-ItemPropertyValue -Path $basePath -Name $Name -ErrorAction Stop
            return ([int]$val -eq 0)
        } catch { return $false }
    }
    $AppsTheme = Get-Flag 'AppsUseLightTheme'
    $SystemTheme = Get-Flag 'SystemUsesLightTheme'
    return ($AppsTheme -or $SystemTheme)
}
# Function to save the file to text or json.
function Save-OutputFile {
    param(
        [Parameter(Mandatory)]
        [string]$Content,
        [Parameter(Mandatory)]
        [string]$DefaultFileName,
        [Parameter(Mandatory)]
        [string]$Filter
    )
    $dlg = New-Object System.Windows.Forms.SaveFileDialog
    $dlg.Filter = $Filter
    $dlg.FileName = $DefaultFileName
    $dlg.OverwritePrompt = $true
    if ($dlg.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) { [System.IO.File]::WriteAllText($dlg.FileName, $Content, [System.Text.UTF8Encoding]::new($true)) }
}
# [NEW] Function to extract an iso for it's wim, esd or swm files.
function Extract-ISO {
    param(
        [Parameter(Mandatory)]
        [string]$Path,
        [Parameter(Mandatory)]
        [ValidateSet('wim','esd','swm','all')]
        [string]$Extension,
        [Parameter(Mandatory)]
        [string]$WorkingDir,
        [Parameter(Mandatory)]
        [scriptblock]$SetProgress,
        [Parameter(Mandatory)]
        [scriptblock]$CompleteProgress,
        [Parameter(Mandatory)]
        [scriptblock]$Info,
        [Parameter(Mandatory)]
        [scriptblock]$Error
    )
    $sevenz = Join-Path $WorkingDir "bin\7z.exe"
    if (-not (Test-Path -LiteralPath $sevenz)) { $sevenz = "$env:ProgramFiles\7-Zip\7z.exe" }
    if (-not (Test-Path -LiteralPath $sevenz)) {
        & $Error "7-Zip does not exist on host system."
        return
    }
    if (-not (Test-Path -LiteralPath $Path)) {
        & $Error "Image not found:`r`n$Path"
        return
    }
    $dir = [IO.Path]::GetDirectoryName($Path)
    $BaseName = [IO.Path]::GetFileNameWithoutExtension($Path)
    $ImgDir = Join-Path -Path $dir -ChildPath "Contents_of_$BaseName"
    if (-not (Test-Path -LiteralPath $ImgDir)) { New-Item -ItemType Directory -Path $ImgDir -Force | Out-Null }
    $pattern = "*.$Extension"
    $args = @('x', $Path, "-o$ImgDir", '-r', '-y', '-aoa', '-bsp1', $pattern)
    $raw = New-Object System.Collections.Generic.List[string]
    & $sevenz @args 2>&1 | ForEach-Object {
        $line = $_.ToString()
        $raw.Add($line)
        if ($line -match '^\s*(\d{1,3})%') {
            $percent = [int]$Matches[1]
            & $SetProgress $Op "Extracting .$Extension files to ${ImgDir}... (${percent}%)" $percent
        }
    }
    $exit = $LASTEXITCODE
    if ($exit -ne 0) {
        & $SetProgress $Op "Extraction failed" 100
        & $Error "Extraction failed (exit $exit).`nOutput:`n$($raw -join "`r`n")"
        return
    }
    $found = Get-ChildItem -Path $ImgDir -Recurse -Filter "*.$Extension" -File -ErrorAction SilentlyContinue
    $msg = if ($found -and $found.Count -gt 0) { "Extraction complete.`nFiles extracted to:`n$ImgDir`n`nFound $($found.Count) .$Extension file(s)." } else { "Extraction complete but no .$Extension files were found inside the image.`nOutput folder:`n$ImgDir" }
    & $CompleteProgress $Op
    & $Info $msg
}
# [NEW] Function to call wimlib-imagex.exe and show a progress bar.
function Process-Container {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$ExePath = $wimlib,
        [Parameter(Mandatory)]
        [string[]]$Arguments,
        [Parameter(Mandatory)]
        [string]$Activity,
        [Parameter(Mandatory)]
        [ValidateSet('Capture And Export','Apply','Split')]
        [string]$Mode
    )
    $target = "of"
    # Overwrite $Activity because it is not neccessary to show the operation.
    $Activity = "Task progress"
    # Uncomment this to hide integrity table calculation progress.
    # However, it will significantly slow down your operation especially
    # in Capture and Export mode. Not that much for Split and Apply.
    # $Arguments += '--check'
    if ($Mode -eq "Capture And Export") {
        $progress = @(
            [regex]'^(?<stage>Archiving file data):\s+(?<done>\d+(?:\.\d+)?)\s+(?<unit>[KMGTPEZY]?i?B) of (?<total>\d+(?:\.\d+)?)\s+\k<unit> \((?<pct>\d+(?:\.\d+)?)%\) done$'
            [regex]'^(?<stage>Calculating integrity table for WIM):\s+(?<done>\d+(?:\.\d+)?)\s+(?<unit>[KMGTPEZY]?i?B) of (?<total>\d+(?:\.\d+)?)\s+\k<unit> \((?<pct>\d+(?:\.\d+)?)%\) done$'
        )
        $output = New-Object System.Collections.Generic.List[string]
        try {
            & $ExePath @Arguments 2>&1 | foreach {
                $line = $_.ToString().Trim()
                if ([string]::IsNullOrWhiteSpace($line)) { return }
                $output.Add($line)
                foreach ($prog in $progress) {
                    $match = $prog.Match($line)
                    if (-not $match.Success) { continue }
                    $pct = [int][double]$match.Groups['pct'].Value
                    $done = $match.Groups['done'].Value
                    $total = $match.Groups['total'].Value
                    $unit = $match.Groups['unit'].Value
                    $stage = $match.Groups['stage'].Value
                    # Some readings may not be accurate! Double check by running the command yourself to verfiy!
                    Set-Progress $Activity "${stage}: $done $unit $target $total $unit (${pct}%)" $pct 2
                    break
                }
            }
        } catch {
            Error $_
        }
    } elseif ($Mode -eq "Apply") {
        $progress = @(
            [regex]'^(?<stage>Creating files):\s+(?<done>\d+(?:\.\d+)?)\s+of\s+(?<total>\d+(?:\.\d+)?)\s+\((?<pct>\d+(?:\.\d+)?)%\)\s+done$'
            [regex]'^(?<stage>Extracting file data):\s+(?<done>\d+(?:\.\d+)?)\s+(?<unit>[KMGTPEZY]?i?B) of (?<total>\d+(?:\.\d+)?)\s+\k<unit> \((?<pct>\d+(?:\.\d+)?)%\) done$'
            [regex]'^(?<stage>Applying metadata to files):\s+(?<done>\d+(?:\.\d+)?)\s+of\s+(?<total>\d+(?:\.\d+)?)\s+\((?<pct>\d+(?:\.\d+)?)%\)\s+done$'
        )
        $output = New-Object System.Collections.Generic.List[string]
        try {
            & $ExePath @Arguments 2>&1 | foreach {
                $line = $_.ToString().Trim()
                if ([string]::IsNullOrWhiteSpace($line)) { return }
                $output.Add($line)
                foreach ($prog in $progress) {
                    $match = $prog.Match($line)
                    if (-not $match.Success) { continue }
                    $pct = [int][double]$match.Groups['pct'].Value
                    $done = $match.Groups['done'].Value
                    $total = $match.Groups['total'].Value
                    $unit = $match.Groups['unit'].Value
                    $stage = $match.Groups['stage'].Value
                    # Some readings may not be accurate! Double check by running the command yourself to verfiy!
                    Set-Progress $Activity "${stage}: $done $unit $target $total $unit (${pct}%)" $pct 2
                    break
                }
            }
        } catch {
            Error $_
        }
    } elseif ($Mode -eq "Split") {
        $progress = @([regex]'^(?<stage>Splitting WIM):\s+(?<done>\d+(?:\.\d+)?)\s+(?<unit>[KMGTPEZY]iB)\s+of\s+(?<total>\d+(?:\.\d+)?)\s+\k<unit>\s+\((?<pct>\d+(?:\.\d+)?)%\)\s+written,\s+part\s+(?<part>\d+)\s+of\s+(?<parts>\d+)\s*$')
        $output = New-Object System.Collections.Generic.List[string]
        try {
            & $ExePath @Arguments 2>&1 | foreach {
                $line = $_.ToString().Trim()
                if ([string]::IsNullOrWhiteSpace($line)) { return }
                $output.Add($line)
                foreach ($prog in $progress) {
                    $match = $prog.Match($line)
                    if ($match.Success) {
                        $pct = [int][double]$match.Groups['pct'].Value
                        $done = $match.Groups['done'].Value
                        $total = $match.Groups['total'].Value
                        $unit = $match.Groups['unit'].Value
                        $part = $match.Groups['part'].Value
                        $parts = $match.Groups['parts'].Value
                        $stage = $match.Groups['stage'].Value
                        # Some readings may not be accurate! Double check by running the command yourself to verfiy!
                        Set-Progress $Activity "${stage}: $done $unit $target $total $unit (Part $part $target $parts ${pct}%)" $pct 2
                        break
                    }
                }
            }
        } catch {
            Error $_
        }
    } else {
        # Will never reach here due to ValidateSet.
        return
    }
    if ($LASTEXITCODE -ne 0) { throw "The operation failed with exit code $LASTEXITCODE.`r`n`r`n$output" }
    Complete-Progress $Activity 2
    return ($output | Out-File -FilePath $env:USERPROFILE\Desktop\wimlib-imagex_output.log -Encoding 'UTF8' -Append -NoClobber)
}
# Function to show finished.
function Show-Finished {
    # Finishup :)
    $Host.UI.RawUI.WindowTitle = "$Op Completed On $Path" # Set the Window Title to say done.
    $MessageExit = if ($Op -eq "SetupProgram") { "Thank you for installing/uninstalling ALOS Image Tools.`r`n`r`nYou may now use the right click menus to quickly start a new operation or task if installed. If uninstalled, we thank you for using ALOS Image Tools.`r`n`r`nCopyright (C) 2023-2026 Aarav Katariya." } else { "Execution has complete.`r`nOperation: $Op.`r`nPath: $Path" }
    Info $MessageExit # Say to the user that the task is complete.
    Exit 0 # And finally, exit the program with a status code of 0.
}
# Function to find all split wim parts.
function Get-SplitWimParts {
    param(
        [Parameter(Mandatory)]
        [string]$SplitPart
    )
    $Dir = Split-Path -LiteralPath $SplitPart
    $PickedStem = [System.IO.Path]::GetFileNameWithoutExtension($SplitPart)
    $RootStem = [regex]::Replace($PickedStem, '\d+$', '')
    Get-ChildItem -LiteralPath $Dir -File -Filter "$RootStem*.swm" | Sort-Object @{
        Expression = {
            $Stem = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
            if ($Stem -eq $RootStem) { return 0 }
            if ($Stem -match ('^' + [regex]::Escape($RootStem) + '(\d+)$')) { return [int]$Matches[1] }
            return [int]::MaxValue
        }
    }, Name | Select-Object -ExpandProperty FullName
}
# [NEW] Function to remove temporary wimfiles.
function Remove-TemporaryWIM {
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )
    if ([string]::IsNullOrWhiteSpace($Path)) { return }
    if (Test-Path -LiteralPath $Path) { Remove-Item -LiteralPath $Path -Force -ErrorAction SilentlyContinue }
}
# Function to acquire the wim information.
function Acquire-WimInformation {
    param(
        [Parameter(Mandatory)]
        [string]$WimPath
    )
    [uint32]$CreationResult = 0
    $WIMGAPI = [ALOSImageTools.NativeWimg]::WIMCreateFile($WimPath, [ALOSImageTools.NativeWimg]::WIM_GENERIC_READ, [ALOSImageTools.NativeWimg]::WIM_OPEN_EXISTING, [ALOSImageTools.NativeWimg]::WIM_FLAG_SHARE_WRITE, [ALOSImageTools.NativeWimg]::WIM_COMPRESS_NONE, [ref]$CreationResult)
    if ($WIMGAPI -eq [IntPtr]::Zero -or $WIMGAPI -eq [IntPtr](-1)) {
        $Err = [Runtime.InteropServices.Marshal]::GetLastWin32Error()
        Error "Sorry! We were unable to open the wimfile for reading!`r`n`r`nThe error is: ${Err}."
    }
    try {
        [ALOSImageTools.NativeWimg+WIM_INFO]$info = New-Object ALOSImageTools.NativeWimg+WIM_INFO
        $size = [uint32][Runtime.InteropServices.Marshal]::SizeOf([type][ALOSImageTools.NativeWimg+WIM_INFO])
        if (-not [ALOSImageTools.NativeWimg]::WIMGetAttributes($WIMGAPI, [ref]$info, $size)) {
            $Err = [Runtime.InteropServices.Marshal]::GetLastWin32Error()
            Error "Sorry! We were unable to read the WIM attributes.`r`n`r`nThe error is: ${Err}."
        }
        return $info
    }
    finally { [ALOSImageTools.NativeWimg]::WIMCloseHandle($WIMGAPI) | Out-Null }
}
# [NEW] Function to set the boot image of a wimfile.
function Set-WimBootIndex {
    param(
        [Parameter(Mandatory)]
        [string]$WimPath,
        [Parameter(Mandatory)]
        [uint32]$Index
    )
    [uint32]$CreationResult = 0
    $WIMGAPI = [ALOSImageTools.NativeWimg]::WIMCreateFile(
        $WimPath,
        [ALOSImageTools.NativeWimg]::WIM_GENERIC_READ -bor [ALOSImageTools.NativeWimg]::WIM_GENERIC_WRITE,
        [ALOSImageTools.NativeWimg]::WIM_OPEN_EXISTING,
        [ALOSImageTools.NativeWimg]::WIM_FLAG_SHARE_WRITE,
        [ALOSImageTools.NativeWimg]::WIM_COMPRESS_NONE,
        [ref]$CreationResult
    )
    if ($WIMGAPI -eq [IntPtr]::Zero -or $WIMGAPI -eq [IntPtr](-1)) {
        $Err = [Runtime.InteropServices.Marshal]::GetLastWin32Error()
        Error "Sorry! We were unable to open the wimfile for reading!`r`n`r`nThe error is: ${Err}."
    }
    try {
        if (-not [ALOSImageTools.NativeWimg]::WIMSetBootImage($WIMGAPI, $Index)) {
            $Err = [Runtime.InteropServices.Marshal]::GetLastWin32Error()
            Error "Sorry! The boot index was unable to change. No changes have been made.`r`n`r`nThe error is: ${Err}."
        }
        [ALOSImageTools.NativeWimg+WIM_INFO]$Verification = New-Object ALOSImageTools.NativeWimg+WIM_INFO
        $size = [uint32][Runtime.InteropServices.Marshal]::SizeOf([type][ALOSImageTools.NativeWimg+WIM_INFO])
        if (-not [ALOSImageTools.NativeWimg]::WIMGetAttributes($WIMGAPI, [ref]$Verification, $size)) {
            $Err = [Runtime.InteropServices.Marshal]::GetLastWin32Error()
            Error "Sorry! The boot index changed successfully but we failed to verfiy that it actually changed.`r`n`r`nThe error is: ${Err}."
        }
        if ($Verification.BootIndex -ne $Index) { Error "Boot index verification failed.`r`n`r`nRequested index: $Index`r`nActual WIM BootIndex: $($Verification.BootIndex)" }
        return $Verification
    }
    finally { [ALOSImageTools.NativeWimg]::WIMCloseHandle($WIMGAPI) | Out-Null }
}
# [NEW] Function to get WIM image metadata.
function Get-WimImageMetadata {
    param(
        [Parameter(Mandatory)]
        [string]$WimPath,
        [Parameter(Mandatory)]
        [uint32]$Index
    )
    [uint32]$CreationResult = 0
    $WIMGAPI = [ALOSImageTools.NativeWimg]::WIMCreateFile(
        $WimPath,
        [ALOSImageTools.NativeWimg]::WIM_GENERIC_READ,
        [ALOSImageTools.NativeWimg]::WIM_OPEN_EXISTING,
        [ALOSImageTools.NativeWimg]::WIM_FLAG_SHARE_WRITE,
        [ALOSImageTools.NativeWimg]::WIM_COMPRESS_NONE,
        [ref]$CreationResult
    )
    if (($WIMGAPI -eq [IntPtr]::Zero) -or ($WIMGAPI -eq [IntPtr](-1))) {
        $Err = [Runtime.InteropServices.Marshal]::GetLastWin32Error()
        Error "Sorry! The WIM cannot be verified.`r`n`r`nThe error is: ${Err}."
    }
    try {
        $xml = [ALOSImageTools.NativeWimg]::GetImageInformation($WIMGAPI)
        $doc = New-Object System.Xml.XmlDocument
        $doc.PreserveWhitespace = $true
        $doc.LoadXml($xml)
        $image = $doc.SelectSingleNode("/WIM/IMAGE[@INDEX='$Index']")
        if ($null -eq $image) { Error "Image index $Index was not found during verification." }
        $n = $image.SelectSingleNode('NAME')
        $dn = $image.SelectSingleNode('DISPLAYNAME')
        $d = $image.SelectSingleNode('DESCRIPTION')
        $dd = $image.SelectSingleNode('DISPLAYDESCRIPTION')
        $f = $image.SelectSingleNode('FLAGS')
        return [PSCustomObject]@{
            Name = if ($null -ne $n) { [string]$n.InnerText } else { '' }
            DisplayName = if ($null -ne $dn) { [string]$dn.InnerText } else { '' }
            Description = if ($null -ne $d) { [string]$d.InnerText } else { '' }
            DisplayDescription = if ($null -ne $dd) { [string]$dd.InnerText } else { '' }
            Flags = if ($null -ne $f) { [string]$f.InnerText } else { '' }
        }
    }
    finally { [ALOSImageTools.NativeWimg]::WIMCloseHandle($WIMGAPI) | Out-Null }
}
# [NEW] Function to change WIM image metadata.
function Set-WimImageMetadata {
    param(
        [Parameter(Mandatory)]
        [string]$WimPath,
        [Parameter(Mandatory)]
        [uint32]$Index,
        [string]$Name,
        [string]$Description,
        [string]$Flags
    )
    [uint32]$CreationResult = 0
    $WIMGAPI = [ALOSImageTools.NativeWimg]::WIMCreateFile(
        $WimPath,
        [ALOSImageTools.NativeWimg]::WIM_GENERIC_WRITE,
        [ALOSImageTools.NativeWimg]::WIM_OPEN_EXISTING,
        [ALOSImageTools.NativeWimg]::WIM_FLAG_SHARE_WRITE,
        [ALOSImageTools.NativeWimg]::WIM_COMPRESS_NONE,
        [ref]$CreationResult
    )
    if (($WIMGAPI -eq [IntPtr]::Zero) -or ($WIMGAPI -eq [IntPtr](-1))) {
        $Err = [Runtime.InteropServices.Marshal]::GetLastWin32Error()
        Error "Sorry! We were unable to open the WIM file for metadata editing.`r`n`r`nThe error is: ${Err}.`r`n`r`nWIM creation result: ${CreationResult}."
    }
    try {
        $ErrorMessage = $null
        $ok = [ALOSImageTools.NativeWimg]::SetImageMetadata(
            $WIMGAPI,
            $Index,
            $Name,
            $Description,
            $Flags,
            [ref]$ErrorMessage
        )
        if (-not $ok) {
            $Err = [Runtime.InteropServices.Marshal]::GetLastWin32Error()
            if ([string]::IsNullOrWhiteSpace($ErrorMessage)) {
                $ErrorMessage = "WIMGAPI error $Err."
            }
            Error "Unable to change WIM image information.`r`n`r`n$ErrorMessage"
        }
    }
    finally { [ALOSImageTools.NativeWimg]::WIMCloseHandle($WIMGAPI) | Out-Null }
}
Clear-Host # Because we have finished defining functions.
# WPF dark mode. (Does not really work.)
if (-not (Test-WpfLightMode)) {
    $DarkMode = Get-WpfDarkTheme
    $app.Resources.MergedDictionaries.Add($DarkMode)
}
# Extra variables for installing windows. Pass -InstallingWindows to define these.
if ($InstallingWindows) {
    $bcdboot = "$env:SYSTEMROOT\System32\bcdboot.exe" # Bcdboot tool to create boot files.
    $mountvol = "$env:SYSTEMROOT\System32\mountvol.exe" # Mountvol tool to mount and unmount volumes.
    $shutdown = "$env:SYSTEMROOT\System32\shutdown.exe" # Shutdown tool. Will be used to reboot into firmware setup.
}
if ($InstallingWindows) { if ($Op -cne "Apply") { Error "Cannot install windows outside of op: Apply." } }
# Setup the environment and test the image path.
$Path = [Environment]::ExpandEnvironmentVariables($Path.Trim('"'))
$Host.UI.RawUI.WindowTitle = "$Op In Progress On $Path" # Set the Window Title text.
$base = [IO.Path]::GetFileNameWithoutExtension($Path) # Get the base filename without the file extension.
$wimlib = $env:WimManage # Search for the WimManage variable. It may be useful.
if (-not $wimlib) { $wimlib = Join-Path $WorkingDir "bin\wimlib-imagex.exe" } # If not defined as an environment variable, use the default binary.
$testpath = $true
if ($Op -ceq "SetupProgram" -and $Path -ceq "SetupProgram") {
    $Host.UI.RawUI.WindowTitle = "Setup Of ALOS Image Tools In Progress ($PID)"
    $testpath = $false
}
if ($testpath) { if (-not (Test-Path -LiteralPath $Path)) { Error "Image file, source or directory not found:`r`n$Path" } } # Automatically fail if the path is not valid. Helper for Op "SetupProgram". Do not remove this. It is very important. :(
# Enter the main body but use case-sensitivity to match Linux software.
switch -CaseSensitive ($Op) {
    # Capture operation. Used to capture a directory to a wimfile.
    'Capture' {
        $src = $Path
        Write-Warning "To capture multiple files, place them in one folder."
        if (-not (Test-Path -LiteralPath $src)) { Error "Source not found:`r`n$src" }
        $DefaultName = "$base.wim"
        $dest = Pick-SaveFile "WIM (*.wim)|*.wim" $DefaultName
        if ([string]::IsNullOrWhiteSpace($dest)) { Error "No destination chosen (save cancelled)." }
        $flags = Read-Host "Set the flags of the index."
        $name = Read-Host "Enter a name for the index."
        $description = Read-Host "Enter a description for the index."
        $CapArgs = @('capture', $src, $dest, $name, $description, '--compress=LZX', '--verbose', "--flags=$flags")
        $DestName = [System.IO.Path]::GetFileName($dest)
        $result = Question -msg "Make the destination WIM bootable?" -Buttons ([System.Windows.Forms.MessageBoxButtons]::YesNoCancel)
        if ($result -eq [System.Windows.Forms.DialogResult]::Yes) { $CapArgs += "--boot" } elseif ($result -eq [System.Windows.Forms.DialogResult]::Cancel) { Error "Operation cancelled." }
        Set-Progress "Capture" "Capturing $src to $DestName" 50
        try {
            $null = Process-Container -ExePath $wimlib -Arguments $CapArgs -Activity "Capture" -Mode "Capture And Export"
        } catch {
            Set-Progress "Capture" "Capture failed" 100
            Error "Capture failed.`r`n$_"
        }
        Complete-Progress "Capture"
        Info "Capture complete.`r`n$dest"
    }
    # Append operation. Used to append a new image to exisiting wimfile.
    'Append' {
        $src = $Path
        Write-Warning "To append multiple files, place them in one folder."
        if (-not (Test-Path -LiteralPath $src)) { Error "Source not found:`r`n$src" }
        $wimfile = Pick-OpenFile "WIM files (*.wim)|*.wim" $null
        if ([string]::IsNullOrWhiteSpace($wimfile)) { Error "No WIM file selected (operation cancelled)." }
        $flags = Read-Host "Set the flags of the index."
        $name = Read-Host "Enter a name for the index."
        $description = Read-Host "Enter a description for the index."
        $AppendArgs = @('append', $src, $wimfile, $name, $description, '--compress=LZX', '--verbose', "--flags=$flags")
        $WimName = [System.IO.Path]::GetFileName($wimfile)
        $result = Question -msg "Is the target WIM a boot image?" -Buttons ([System.Windows.Forms.MessageBoxButtons]::YesNoCancel)
        $bootwim = $false
        if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
            $AppendArgs += "--boot"
            $bootwim = $true
        } elseif ($result -eq [System.Windows.Forms.DialogResult]::Cancel) {
            Error "Operation cancelled."
        }
        Set-Progress "Append" "Appending $src to $WimName" 50
        try {
            $null = Process-Container -ExePath $wimlib -Arguments $AppendArgs -Activity "Append" -Mode "Capture And Export"
        } catch {
            Set-Progress "Append" "Append failed" 100
            Error "Append failed.`r`n$_"
        }
        $out = $wimfile + "new"
        $esd = Question "Do you want to convert the wimfile to a smaller ESD format? It is resource-intensive though."
        if ($esd -eq [System.Windows.Forms.DialogResult]::Yes) {
             Clear-Host
             $final = [IO.Path]::GetFileNameWithoutExtension($wimfile)
             $OptArgs = @('export', $wimfile, 'all', ${final}.esd, '--compress=LZMS', '--solid')
             Write-Warning $CompressWarn
             if ($bootwim) {
                $OptArgs += '--boot'
                if ('--boot' -in $OptArgs) { Write-Host "A boot image has been targeted and it will be made bootable." } # Verify the --boot flag exists.
                $esdfile = $true
            }
        } else {
            $OptArgs = @('optimize', $wimfile, '--compress=LZX')
            if ($bootwim) {
                $OptArgs += '--boot'
                if ('--boot' -in $OptArgs) { Write-Host "A boot image has been targeted and it will be made bootable." } # Verify the --boot flag exists.
                $esdfile = $false
            }
        }
        Set-Progress "Append" "Optimising..." 75
        try {
            $null = Process-Container -ExePath $wimlib -Arguments $OptArgs -Activity "Optimise" -Mode "Capture And Export"
        } catch {
            Set-Progress "Append" "Optimise failed" 100
            Error "Optimise failed.`r`n$($_.Exception.Message)"
        }
        if ($bootwim -eq $true) {
            Remove-Item -Path $wimfile -Force
            Rename-Item -Path $out -NewName $wimfile
        }
        if ($esdfile) { Remove-Item -Path $wimfile -Force }
        Complete-Progress "Append"
        Info "Append complete.`r`n$wimfile"
    }
    # Mount operation. Used to mount a wimfile to a certain directory and then let users service Windows images.
    # Requires the DISM module or else no function.
    'Mount' {
        Set-Progress "Mount" "Selecting index" 5
        $idx = Pick-Index -Path $Path
        Set-Progress "Mount" "Selecting mount folder" 15
        $mnt = Pick-Folder "Select mount folder" (Join-Path $env:TEMP "${base}.mnt")
        Set-Progress "Mount" "Mounting image index $idx" 50
        try {
            Mount-WindowsImage -ImagePath $Path -Index $idx -Path $mnt -ErrorAction Stop
        } catch {
            Set-Progress "Mount" "Mount failed" 100
            Error "Mount failed.`n$($_.Exception.Message)"
        }
        Set-Progress "Mount" "Mounted - waiting for user to unmount" 70
        $result = Question -msg "The image has mounted. You can make changes to the image at:`r`n${mnt}.`r`nWhen you have finished, return to this message box and choose if you want to save or discard.
`r`nYes = Save`r`nNo = Discard" -Buttons ([System.Windows.Forms.MessageBoxButtons]::YesNo) -Icon ([System.Windows.Forms.MessageBoxIcon]::Question)
        if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
            Set-Progress "Mount" "Unmounting and saving changes." 90
            try {
                Dismount-WindowsImage -Path $mnt -Save -ErrorAction Stop
            } catch {
                Set-Progress "Mount" "Dismount (save) failed" 100
                Error "Dismount and save failed.`r`n$($_.Exception.Message)"
            }
        } else {
            Set-Progress "Mount" "Unmounting and discarding changes" 90
            try {
                Dismount-WindowsImage -Path $mnt -Discard -ErrorAction Stop
            } catch {
                Set-Progress "Mount" "Dismount (discard) failed" 100
                Error "Dismount and discard failed.`r`n$($_.Exception.Message)"
            }
        }
        Complete-Progress "Mount"
    }
    # Export WIM operation. Used to export one or more images to a new wimfile.
    # Good for separation of indexes.
    'ExportWIM' {
        Info "You can export ONE or MORE indices from a source file to a single WIM file."
        Set-Progress "ExportWIM" "Selecting index(es)" 5
        $selected = Pick-Index -Path $Path -MultipleImages
        if ($null -eq $selected) { Error "No indices selected." }
        if ($selected -is [System.Array]) { $indices = $selected | ForEach-Object { [int]$_ } } else { $indices = @([int]$selected) }
        Set-Progress "ExportWIM" "Choosing destination" 15
        $dest = Pick-SaveFile "WIM (*.wim)|*.wim" "$base.wim"
        if ([string]::IsNullOrWhiteSpace($dest)) { Error "No destination chosen (save cancelled)." }
        $destName = [System.IO.Path]::GetFileName($dest)
        $folder = [IO.Path]::GetDirectoryName($dest)
        if ([string]::IsNullOrWhiteSpace($folder)) { $folder = (Get-Location).ProviderPath }
        if (-not (Test-Path -LiteralPath $folder)) { New-Item -ItemType Directory -Path $folder -Force | Out-Null }
        $bootable = $false
        $result = Question -msg "Should the exported WIM be marked bootable?" -Buttons ([System.Windows.Forms.MessageBoxButtons]::YesNoCancel)
        if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
            $bootable = $true
            Write-Host "Marked exported WIM as bootable."
        } elseif ($result -eq [System.Windows.Forms.DialogResult]::Cancel) {
            Error "Operation cancelled."
        }
        $total = $indices.Count
        $i = 0
        $failures = @()
        foreach ($idx in $indices) {
            $i++
            $pct = [int](10 + (($i / $total) * 80))
            Set-Progress "ExportWIM" "Exporting index $idx to $destName" $pct
            $exportArgs = @('export', $Path, $idx, $dest, '--compress=LZX')
            if ($bootable) { $exportArgs += '--boot' }
            try {
                $null = Process-Container -ExePath $wimlib -Arguments $exportArgs -Activity "ExportWIM" -Mode "Capture And Export"
            } catch {
                Write-Error "Error during export of index ${idx}." -ErrorAction Continue
                $failures += $idx
            }
        }
        if ($failures.Count -gt 0) {
            $msg = "Export encountered errors.`nErrored indices: $([string]::Join(', ',$failures))`nDestination file: $dest"
            Set-Progress "ExportWIM" "Export finished (with errors)" 100
            Error $msg
        } else {
            if ($bootable) {
                $out = $dest + 'new'
                Set-Progress "ExportWIM" "Now optimise the wimfile ($dest will be bootable)..." 90
                try {
                    $null = Process-Container -ExePath $wimlib -Arguments @('export', $dest, 'all', $out, '--compress=LZX', '--boot') -Activity "ExportWIM" -Mode "Capture And Export"
                } catch {
                    Remove-Item -Path $out -Force
                    Error "Optimisation could not happen due to $($_.Exception.Message)."
                }
            } else {
                Set-Progress "ExportWIM" "Now optimise the wimfile ($dest will not be bootable)..." 90
                try {
                    $null = Process-Container -ExePath $wimlib -Arguments @('optimize', $dest, '--compress=LZX') -Activity "ExportWIM" -Mode "Capture And Export"
                } catch {
                    Remove-Item -Path $out -Force
                    Error "Optimisation could not happen due to $($_.Exception.Message)."
                }
            }
            if ($bootable) {
                Remove-Item -Path $dest -Force
                Rename-Item -LiteralPath $out -NewName $dest -Force
            }
            Complete-Progress "ExportWIM"
            Info "All selected indices exported into:`n$dest"
        }
    }
    # Export ESD operation. Used to export one or more images to a new esdfile.
    # Good for separation of indexes.
    'ExportESD' {
        Info "You can export ONE or MORE indices from a source file to a single ESD file."
        Set-Progress "ExportESD" "Selecting index(es)" 5
        $selected = Pick-Index -Path $Path -MultipleImages
        if ($null -eq $selected) { Error "No indices selected." }
        if ($selected -is [System.Array]) { $indices = $selected | ForEach-Object { [int]$_ } } else { $indices = @([int]$selected) }
        Write-Warning $CompressWarn
        Set-Progress "ExportESD" "Choosing destination" 15
        $destEsd = Pick-SaveFile "ESD (*.esd)|*.esd" "$base.esd"
        if ([string]::IsNullOrWhiteSpace($destEsd)) { Error "No destination chosen (save cancelled)." }
        $folder = [IO.Path]::GetDirectoryName($destEsd)
        if ([string]::IsNullOrWhiteSpace($folder)) { $folder = (Get-Location).ProviderPath }
        if (-not (Test-Path -LiteralPath $folder)) { New-Item -ItemType Directory -Path $folder -Force | Out-Null }
        $bootable = $false
        $result = Question -msg "Should the exported ESD be marked bootable?" -Buttons ([System.Windows.Forms.MessageBoxButtons]::YesNoCancel)
        if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
            $bootable = $true
            Write-Host "Marked exported ESD as bootable."
        } elseif ($result -eq [System.Windows.Forms.DialogResult]::Cancel) {
            Error "Operation cancelled."
        }
        $tmpWim = Join-Path $folder ("${base}_tmp.wim")
        if (Test-Path -LiteralPath $tmpWim) { Remove-Item -LiteralPath $tmpWim -Force -ErrorAction SilentlyContinue }
        $total = $indices.Count
        $i = 0
        $failures = @()
        foreach ($idx in $indices) {
            $i++
            $pct = [int](10 + (($i / $total) * 70))
            Set-Progress "ExportESD" "Building temporary wim (Currently on index $idx)" $pct
            $exportArgs = @('export', $Path, $idx, $tmpWim, '--compress=LZX')
            if ($bootable) { $exportArgs += '--boot' }
            try {
                $null = Process-Container -ExePath $wimlib -Arguments $exportArgs -Activity "ExportESD" -Mode "Capture And Export"
            } catch {
                Write-Error "Error during export of index ${idx}." -ErrorAction Continue
                $failures += $idx
            }
        }
        if ($failures.Count -gt 0) {
            $msg = "Export to temporary WIM completed with errors.`nErrored indices: $([string]::Join(', ',$failures))`nTemporary file: $tmpWim"
            Set-Progress "ExportESD" "Export finished (with errors)" 100
            Warn $msg
            if (Test-Path -LiteralPath $tmpWim) { Remove-Item -LiteralPath $tmpWim -Force -ErrorAction SilentlyContinue }
            Error "One or more ExportESD operations failed (during WIM creation)."
        }
        Set-Progress "ExportESD" "Converting WIM to ESD" 85
        $ESDArgs = @('export', $tmpWim, 'all', $destEsd, '--compress=LZMS', '--solid')
        if ($bootable) { $ESDArgs += '--boot' }
        try {
            $null = Process-Container -ExePath $wimlib -Arguments $ESDArgs -Activity "ExportESD" -Mode "Capture And Export"
        } catch {
            Set-Progress "ExportESD" "Conversion failed" 100
            if (Test-Path -LiteralPath $tmpWim) { Remove-Item -LiteralPath $tmpWim -Force -ErrorAction SilentlyContinue }
            Error "Errored to convert temporary WIM to ESD (exit $LASTEXITCODE)."
        }
        if (Test-Path -LiteralPath $tmpWim) { Remove-Item -LiteralPath $tmpWim -Force -ErrorAction SilentlyContinue }
        Complete-Progress "ExportESD"
        Info "All selected indices exported into:`n$destEsd"
    }
    # Get Info operation. Used to obtain technicial properties of a wim, esd or swm file.
    'GetInfo' {
        $OldWarning = $WarningPreference
        $OldVerbose = $VerbosePreference
        $OldInformation = $InformationPreference
        $WarningPreference = 'SilentlyContinue'
        $VerbosePreference = 'SilentlyContinue'
        $InformationPreference = 'SilentlyContinue'
        function Format-Bytes {
            param([long]$bytes)
            if ($bytes -ge 1TB) { "{0:N2} TB" -f ($bytes / 1TB) } elseif ($bytes -ge 1GB) { "{0:N2} GB" -f ($bytes / 1GB) } elseif ($bytes -ge 1MB) { "{0:N2} MB" -f ($bytes / 1MB) } elseif ($bytes -ge 1KB) { "{0:N2} KB" -f ($bytes / 1KB) } else { "$bytes B" }
        }
        try {
            Write-Progress -Id 1 -Activity "GetInfo" -Status "Gathering info..." -PercentComplete 2
            $raw = & $wimlib info $Path 2>&1
            if ($LASTEXITCODE -ne 0) {
                Write-Progress -Id 1 -Activity "GetInfo" -Status "Getting information failed..." -PercentComplete 100
                Error "Getting information failed:`n$raw"
            }
            Write-Progress -Id 1 -Activity "GetInfo" -Status "Collecting file info..." -PercentComplete 4
            $FileInfo = Get-Item -LiteralPath $Path -ErrorAction Stop
            $ContainerSize = $FileInfo.Length
            if (-not ($NoHashes)) {
                Write-Progress -Id 1 -Activity "GetInfo" -Status "Computing SHA512 hash..." -PercentComplete 6
                $FileHashSHA512 = (Get-FileHash -Path $Path -Algorithm SHA512).Hash
                Write-Progress -Id 1 -Activity "GetInfo" -Status "Computing SHA384 hash..." -PercentComplete 8
                $FileHashSHA384 = (Get-FileHash -Path $Path -Algorithm SHA384).Hash
                Write-Progress -Id 1 -Activity "GetInfo" -Status "Computing SHA256 hash..." -PercentComplete 10
                $FileHashSHA256 = (Get-FileHash -Path $Path -Algorithm SHA256).Hash
                Write-Progress -Id 1 -Activity "GetInfo" -Status "Computing SHA1 hash..." -PercentComplete 12
                $FileHashSHA1 = (Get-FileHash -Path $Path -Algorithm SHA1).Hash
                Write-Progress -Id 1 -Activity "GetInfo" -Status "Computing MD5 hash..." -PercentComplete 14
                $FileHashMD5 = (Get-FileHash -Path $Path -Algorithm MD5).Hash
                Write-Progress -Id 1 -Activity "GetInfo" -Status "Computing CRC64 hash..." -PercentComplete 16
                $FileHashCRC64 = Get-CRC -Path $Path -Algorithm CRC64
                Write-Progress -Id 1 -Activity "GetInfo" -Status "Computing CRC32 hash..." -PercentComplete 18
                $FileHashCRC32 = Get-CRC -Path $Path -Algorithm CRC32
            }
            Write-Progress -Id 1 -Activity "GetInfo" -Status "Getting file metadata..." -PercentComplete 20
            $sb = New-Object System.Text.StringBuilder
            $sb.AppendLine("================= Your Image Info Has Been Saved =================") | Out-Null
            $sb.AppendLine("Image file: $Path") | Out-Null
            $sb.AppendLine("File size: $(Format-Bytes $ContainerSize) ($ContainerSize bytes)") | Out-Null
            $sb.AppendLine("") | Out-Null
            if (-not ($NoHashes)) {
                $sb.AppendLine("SHA512: $FileHashSHA512") | Out-Null
                $sb.AppendLine("SHA384: $FileHashSHA384") | Out-Null
                $sb.AppendLine("SHA256: $FileHashSHA256") | Out-Null
                $sb.AppendLine("SHA1: $FileHashSHA1") | Out-Null
                $sb.AppendLine("MD5: $FileHashMD5") | Out-Null
                $sb.AppendLine("CRC64: $FileHashCRC64") | Out-Null
                $sb.AppendLine("CRC32: $FileHashCRC32") | Out-Null
                $sb.AppendLine("") | Out-Null
            } else {
                $sb.AppendLine("You have chosen not to compute the SHA512 hash.") | Out-Null
                $sb.AppendLine("You have chosen not to compute the SHA384 hash.") | Out-Null
                $sb.AppendLine("You have chosen not to compute the SHA256 hash.") | Out-Null
                $sb.AppendLine("You have chosen not to compute the SHA1 hash.") | Out-Null
                $sb.AppendLine("You have chosen not to compute the MD5 hash.") | Out-Null
                $sb.AppendLine("You have chosen not to compute the CRC64 hash.") | Out-Null
                $sb.AppendLine("You have chosen not to compute the CRC32 hash.") | Out-Null
                $sb.AppendLine("") | Out-Null
            }
            $lines = $raw -split "`r?`n"
            $wim = [ordered]@{}
            $images = @()
            $current = $null
            $total = $lines.Count
            $i = 0
            foreach ($line in $lines) {
                $i++
                $pct = [int](($i / $total) * 80)
                Write-Progress -Id 1 -Activity "GetInfo" -Status "Saving information... ($i of $total)" -PercentComplete $pct
                if ($line -match '^\s*([^:]+):\s*(.*)$') {
                    $key = $matches[1].Trim()
                    $val = $matches[2].Trim()
                    if ($key -ieq 'Index') {
                        if ($current) { $images += $current }
                        $current = [ordered]@{ Index = [int]$val }
                    }
                    elseif ($current) {
                        $current[$key -replace ' ', ''] = $val
                    }
                    else {
                        $wim[$key -replace ' ', ''] = $val
                    }
                }
                elseif ($line.Trim() -eq '') {
                    continue
                }
                else {
                    if ($current) {
                        if (-not $current.Contains('Notes')) {
                            $current['Notes'] = $line.Trim()
                        }
                        else {
                            $current['Notes'] += "`n" + $line.Trim()
                        }
                    }
                    else {
                        if (-not $wim.Contains('Notes')) {
                            $wim['Notes'] = $line.Trim()
                        }
                        else {
                            $wim['Notes'] += "`n" + $line.Trim()
                        }
                    }
                }
            }
            if ($current) { $images += $current }
            Write-Progress -Id 1 -Activity "GetInfo" -Status "Formatting results" -PercentComplete 85
            $sb.AppendLine("Here is the information about your imagefile:") | Out-Null
            $sb.AppendLine("----------------------------------------------------------------------------------------------------") | Out-Null
            $sb.AppendLine(("Path".PadRight(15)) + ": " + ([IO.Path]::GetFileName($Path))) | Out-Null
            $labels = @{
                GUID = 'GUID'
                Version = 'Version'
                ImageCount = 'Image Count'
                Compression = 'Compression'
                ChunkSize = 'Chunk Size'
                PartNumber = 'Part Number'
                BootIndex = 'Boot Index'
                Size = 'Size'
                Attributes = 'Attributes'
            }
            foreach ($k in $labels.Keys) { if ($wim[$k]) { $sb.AppendLine(("{0,-15}: {1}" -f $labels[$k], $wim[$k])) | Out-Null } }
            $sb.AppendLine("") | Out-Null
            $sb.AppendLine("All the images in your imagefile that you saved:") | Out-Null
            $sb.AppendLine("-----------------") | Out-Null
            $sb.AppendLine("") | Out-Null
            foreach ($img in $images) {
                $imageBlock = [ordered]@{
                    "Index" = $img.Index
                    "Name" = $img.Name
                    "Description" = $img.Description
                    "Display Name" = $img.DisplayName
                    "Display Description" = $img.DisplayDescription
                    "Directory Count" = $img.DirectoryCount
                    "File Count" = $img.FileCount
                    "Total Bytes" = $img.TotalBytes
                    "Hard Link Bytes" = $img.HardLinkBytes
                    "Creation Time" = $img.CreationTime
                    "Last Modification Time" = $img.LastModificationTime
                    "Architecture" = $img.Architecture
                    "Product Name" = $img.ProductName
                    "Edition ID" = $img.EditionID
                    "Installation Type" = $img.InstallationType
                    "Product Type" = $img.ProductType
                    "Product Suite" = $img.ProductSuite
                    "Languages" = $img.Languages
                    "Default Language" = $img.DefaultLanguage
                    "System Root" = $img.SystemRoot
                    "Major Version" = $img.MajorVersion
                    "Minor Version" = $img.MinorVersion
                    "Build" = $img.Build
                    "Service Pack Build" = $img.ServicePackBuild
                    "Service Pack Level" = $img.ServicePackLevel
                    "Flags" = $img.Flags
                    "WIMBoot compatible" = $img.WIMBootcompatible
                }
                foreach ($k in $ImageBlock.Keys) { if ($null -ne $ImageBlock[$k] -and $ImageBlock[$k] -ne "") { $sb.AppendLine(("{0,-22}: {1}" -f $k, $ImageBlock[$k])) | Out-Null } }
                $sb.AppendLine("") | Out-Null
            }
            $JSON = [ordered]@{
                ImageFile = $Path
                FileSizeBytes = $ContainerSize
                FileSize = (Format-Bytes $ContainerSize)
                SHA512 = $FileHashSHA512
                SHA384 = $FileHashSHA384
                SHA256 = $FileHashSHA256
                SHA1 = $FileHashSHA1
                MD5 = $FileHashMD5
                CRC64 = $FileHashCRC64
                CRC32 = $FileHashCRC32
                Created = $FileInfo.CreationTime
                Modified = $FileInfo.LastWriteTime
                WIM = $wim
                Images = $images
            }
            $JsonText = $JSON | ConvertTo-Json -Depth 20
            $TempFile = Join-Path $env:TEMP ("IMAGEINFO_{0}_{1}.txt" -f $base, (Get-Random))
            $sb.ToString() | Out-File -FilePath $TempFile -Encoding UTF8
            Write-Progress -Id 1 -Activity "GetInfo" -Status "Displaying results" -PercentComplete 95
            if ($WPFUI) {
                $Window = New-Object System.Windows.Window
                $Window.Title = "Your Image Info Has Been Saved - $Path"
                $Window.Width = 1000
                $Window.Height = 800
                $Window.WindowStartupLocation = [System.Windows.WindowStartupLocation]::CenterScreen
                if (-not (Test-WpfLightMode)) { $window.Resources.MergedDictionaries.Add((Get-WpfDarkTheme)) }
                $root = New-Object System.Windows.Controls.DockPanel
                $ButtonPanel = New-Object System.Windows.Controls.StackPanel
                $ButtonPanel.Orientation = 'Horizontal'
                $ButtonPanel.Margin = New-Object System.Windows.Thickness(10,10,10,10)
                [System.Windows.Controls.DockPanel]::SetDock($buttonPanel, 'Top')
                $BtnSaveText = New-Object System.Windows.Controls.Button
                $BtnSaveText.Content = 'Save to Text File'
                $BtnSaveText.Margin = New-Object System.Windows.Thickness(0,0,8,0)
                $BtnSaveText.Padding = New-Object System.Windows.Thickness(12,6,12,6)
                $BtnSaveJson = New-Object System.Windows.Controls.Button
                $BtnSaveJson.Content = 'Save to JSON file'
                $BtnSaveJson.Margin = New-Object System.Windows.Thickness(0,0,8,0)
                $BtnSaveJson.Padding = New-Object System.Windows.Thickness(12,6,12,6)
                $BtnCopy = New-Object System.Windows.Controls.Button
                $BtnCopy.Content = 'Copy'
                $BtnCopy.Padding = New-Object System.Windows.Thickness(12,6,12,6)
                $TextBox = New-Object System.Windows.Controls.TextBox
                $TextBox.IsReadOnly = $true
                $TextBox.TextWrapping = [System.Windows.TextWrapping]::NoWrap
                $TextBox.VerticalScrollBarVisibility = "Auto"
                $TextBox.HorizontalScrollBarVisibility = "Auto"
                $TextBox.FontFamily = "Segoe UI"
                $TextBox.FontSize = 9
                $TextBox.Text = Get-Content -Path $tempFile -Raw
                $BtnSaveText.Add_Click({ Save-OutputFile -Content $TextBox.Text -DefaultFileName ("IMAGEINFO_{0}.txt" -f $base) -Filter 'Text files (*.txt)|*.txt|All files (*.*)|*.*' })
                $BtnSaveJson.Add_Click({ Save-OutputFile -Content $JsonText -DefaultFileName ("IMAGEINFO_{0}.json" -f $base) -Filter 'JSON files (*.json)|*.json|All files (*.*)|*.*' })
                $BtnCopy.Add_Click({ Set-Clipboard -Value $TextBox.Text })
                $ButtonPanel.Children.Add($BtnSaveText) | Out-Null
                $ButtonPanel.Children.Add($BtnSaveJson) | Out-Null
                $ButtonPanel.Children.Add($BtnCopy) | Out-Null
                [System.Windows.Controls.DockPanel]::SetDock($TextBox, 'Bottom')
                $root.Children.Add($buttonPanel) | Out-Null
                $root.Children.Add($textBox) | Out-Null
                $Window.Content = $root
            } else {
                $Form = New-Object System.Windows.Forms.Form
                $Form.Text = "Your Image Info Has Been Saved - $Path"
                $Form.Width = 1000
                $Form.Height = 800
                $Form.StartPosition = 'CenterScreen'
                $Form.TopMost = $false
                $ButtonPanel = New-Object System.Windows.Forms.FlowLayoutPanel
                $ButtonPanel.Dock = 'Top'
                $ButtonPanel.AutoSize = $true
                $ButtonPanel.WrapContents = $false
                $ButtonPanel.Padding = New-Object System.Windows.Forms.Padding(10)
                $ButtonPanel.FlowDirection = 'LeftToRight'
                $BtnSaveText = New-Object System.Windows.Forms.Button
                $BtnSaveText.Text = 'Save to Text File'
                $BtnSaveText.AutoSize = $true
                $BtnSaveJson = New-Object System.Windows.Forms.Button
                $BtnSaveJson.Text = 'Save to JSON file'
                $BtnSaveJson.AutoSize = $true
                $BtnCopy = New-Object System.Windows.Forms.Button
                $BtnCopy.Text = 'Copy'
                $BtnCopy.AutoSize = $true
                $Txt = New-Object System.Windows.Forms.TextBox
                $Txt.Multiline = $true
                $Txt.ReadOnly = $true
                $Txt.ScrollBars = 'Both'
                $Txt.WordWrap = $false
                $Txt.Dock = 'Fill'
                $Txt.Font = New-Object System.Drawing.Font("Segoe UI",9)
                $Txt.Text = Get-Content -Path $tempFile -Raw
                $BtnSaveText.Add_Click({ Save-OutputFile -Content $txt.Text -DefaultFileName ("IMAGEINFO_{0}.txt" -f $base) -Filter 'Text files (*.txt)|*.txt|All files (*.*)|*.*' })
                $BtnSaveJson.Add_Click({ Save-OutputFile -Content $JsonText -DefaultFileName ("IMAGEINFO_{0}.json" -f $base) -Filter 'JSON files (*.json)|*.json|All files (*.*)|*.*' })
                $BtnCopy.Add_Click({ Set-Clipboard -Value $txt.Text })
                $ButtonPanel.Controls.Add($btnSaveText) | Out-Null
                $ButtonPanel.Controls.Add($btnSaveJson) | Out-Null
                $ButtonPanel.Controls.Add($btnCopy) | Out-Null
                $form.Controls.Add($txt)
                $form.Controls.Add($buttonPanel)
                $ThemeControl = Is-LightModeOn
                if ($ThemeControl.Apps -or $ThemeControl.System) {
                    Enable-DarkMode $form
                    Enable-DarkMode $txt
                    Enable-DarkMode $buttonPanel
                    Enable-DarkMode $btnSaveText
                    Enable-DarkMode $btnSaveJson
                    Enable-DarkMode $btnCopy
                }
            }
            Write-Progress -Id 1 -Activity "GetInfo" -Completed
            Write-Host "Done! Check the output window for results."
            if ($WPFUI) { $null = $Window.ShowDialog() } else { $null = $Form.ShowDialog() }
        } catch {
            Error "An error occurred while gathering info:`r`n$_"
        }
        finally {
            $WarningPreference = $OldWarning
            $VerbosePreference = $OldVerbose
            $InformationPreference = $OldInformation
        }
    }
    # Apply operation. Used to apply a wim, esd or swm file to a directory or drive.
    # Pass -InstallingWindows to turn this into a Windows installer workflow.
    'Apply' {
        Set-Progress "Apply" "Selecting index" 5
        $idx = Pick-Index -Path $Path
        if ($InstallingWindows) {
            Set-Progress "Apply" "Validating Windows edition" 10
            $WIMInfo = & $wimlib info $Path $idx 2>&1
            if ($LASTEXITCODE -ne 0) {
                Set-Progress "Apply" "Edition validation failed" 100
                Error "Unable to read the selected image's edition information.`r`n`r`n$WIMInfo"
            }
            $EditionID = ''
            foreach ($line in $WIMInfo -split "`r?`n") {
                if ($line -match '^\s*Flags\s*:\s*(.+?)\s*$') {
                    $EditionID = $matches[1].Trim()
                    break
                }
            }
            $BannedMatch = $null
            $ClientMatch = $null
            $ServerMatch = $null
            if (-not [string]::IsNullOrWhiteSpace($EditionID)) {
                $BannedMatch = @($WindowsEditionIDs.Banned) | Where-Object { $_ -ieq $EditionID } | Select-Object -First 1
                if ($BannedMatch) {
                    Set-Progress "Apply" "Edition denied" 100
                    Error "The selected image cannot be applied.`r`n`r`nEdition ID: $EditionID`r`nReason: This is probably an industrial edition."
                }
                $ClientMatch = @($WindowsEditionIDs.Client) | Where-Object { $_ -ieq $EditionID } | Select-Object -First 1
                $ServerMatch = @($WindowsEditionIDs.Server) | Where-Object { $_ -ieq $EditionID } | Select-Object -First 1
            }
            if ($ClientMatch) { $EditionCategory = 'Client' } elseif ($ServerMatch) { $EditionCategory = 'Server' } else { Complete-Progress "Apply"; Error "This is not a valid Windows edition.`r`n`r`nYour Index Flags Are: $(if ([string]::IsNullOrWhiteSpace($EditionID)) { '<empty>' } else { $EditionID })`r`nYou must present a proper Client or Server edition." }
            Set-Progress "Apply" "Validated $EditionCategory edition: $EditionID" 15
        }
        Set-Progress "Apply" "Selecting target directory" 20
        [string]$dir = Pick-Folder "Select apply directory" (Join-Path $env:TEMP "Applied_$base")
        if ($InstallingWindows) {
            Set-Progress "Apply" "Validating directory..." 30
            $check = Test-Root -Path $dir
            if ($check.Error) { Error $check.Error }
            if (-not ($check.IsRoot -and $check.IsNTFS)) {
                if ($LASTEXITCODE -ne 0) { Set-Progress "Apply" "Apply failed" 100; Error "Apply failed." }
                Error "Target must be the root of an NTFS drive (e.g. C:\).`r`nSelected: $(Coalesce $check.Resolved $dir)`r`nDetected filesystem: $(Coalesce $check.FileSystem 'Unknown')"
            }
            try {
                $root = $check.Root
                if (-not $root) { Error "Unable to determine the drive root for the selected path." }
                $DriveLetter = $root.Substring(0,1)
                if (-not ($DriveLetter -match '^[A-Za-z]$')) { Error "Could not determine a valid drive letter from: $root" }
                Set-Progress "Formatting drive ${DriveLetter}..." 40
                Format-Volume -DriveLetter "$DriveLetter" -FileSystem NTFS -NewFileSystemLabel "Windows" -ErrorAction Stop
            } catch {
                Error "Formatting failed or was cancelled by the user.`r`n`r`nError details:`r`n$_"
            }
        }
        Set-Progress "Apply" "Applying index $idx to $dir" 50
        try { Process-Container -ExePath $wimlib -Arguments @('apply', $Path, $idx, $dir) -Activity Apply -Mode "Apply" } catch { Set-Progress "Apply" "Apply failed" 100; Error "Apply failed." }
        if ($InstallingWindows) {
            Set-Progress "Apply" "Creating bootfiles." 80
            & $mountvol @('A:\', '/s') > $null 2>&1 # Mount EFI system partition.
            & $bcdboot @("$dir\Windows", '/s', 'A:\', '/f', 'ALL') > $null 2>&1 # Create boot files or update bcd.
            & $mountvol @('A:\', '/d') > $null 2>&1 # Unmount EFI system partition.
            $result = Question -msg "Completed. Do you want to reboot into firmware to configure boot order?" -Buttons ([System.Windows.Forms.MessageBoxButtons]::YesNo) -Icon ([System.Windows.Forms.MessageBoxIcon]::Information)
            if ($result -eq [System.Windows.Forms.DialogResult]::Yes) { & shutdown @('/r', '/fw', '/f', '/t', 0) } # If they consent, reboot to firmware setup. :)
        }
        Complete-Progress "Apply"
    }
    # Apply and Delete Image operation. Same as apply but deletes the selected index afterward.
    # Like a one-time where you do not need the image after applying.
    # Does not support the install windows workflow. :(
    'ApplyAndDeleteImage' {
        Set-Progress "ApplyAndDeleteImage" "Validating file extension" 5
        $ext = [IO.Path]::GetExtension($Path).ToLowerInvariant()
        if ($ext -in '.esd', '.swm') { Error "ApplyAndDeleteImage is not permitted on ESD or SWM files." }
        Set-Progress "ApplyAndDeleteImage" "Selecting index" 15
        $idx = Pick-Index -Path $Path
        Set-Progress "ApplyAndDeleteImage" "Selecting target directory" 25
        $dir = Pick-Folder "Select apply directory" (Join-Path $env:TEMP "Applied_$base")
        Set-Progress "ApplyAndDeleteImage" "Applying index $idx" 50
        Process-Container -ExePath $wimlib -Arguments @('apply', $Path, $idx, $dir) -Activity ApplyAndDeleteImage -Mode Apply
        if ($LASTEXITCODE -ne 0) { Set-Progress "ApplyAndDeleteImage" "Apply failed" 100; Error "Apply failed. Deletion aborted." }
        Set-Progress "ApplyAndDeleteImage" "Deleting index $idx from $Path" 75
        $raw = & $wimlib @('delete', $Path, $idx) > $null 2>&1
        if ($LASTEXITCODE -ne 0) {
            Warn "Apply succeeded but automatic deletion FAILED.`r`n`r`n$raw"
            Error "Apply completed, but deletion failed."
        } else {
            Info "Apply and automatic delete completed successfully.`r`nApplied to: $dir`r`nDeleted index: $idx from $Path"
        }
        Complete-Progress "ApplyAndDeleteImage"
    }
    # Split WIM operation. Used for splitting WIM files into SWM files. Cannot edit afterward.
    # See the JoinWIM and JoinESD operations for rebuilding the Split WIMs.
    'SplitWIM' {
        Set-Progress "SplitWIM" "Choosing destination" 10
        $dest = Pick-SaveFile "SWM (*.swm)|*.swm" "$base.swm"
        $size = [int](Read-Host "Enter split size")
        if ($size -gt 4092) { Warn "You will not be able to copy the split files onto any FAT32 volume!" }
        Set-Progress "SplitWIM" "Splitting into $dest (size $size)" 40
        Process-Container -ExePath $wimlib -Arguments @('split', $Path, $dest, $size) -Activity SplitWIM -Mode "Split"
        if ($LASTEXITCODE -ne 0) { Set-Progress "ALOS Image Tools" "Split failed" 100; Error "SplitWIM failed." }
        Complete-Progress "SplitWIM"
    }
    # Recompress WIM operation. Used to optimise the size of the WIM file.
    'RecompressWIM' {
        Set-Progress "RecompressWIM" "Optimising/compressing WIM" 50
        $destName = [System.IO.Path]::GetFileName($Path)
        $result = Question -msg "Is this WIM a boot image that requires re-export?" -Buttons ([System.Windows.Forms.MessageBoxButtons]::YesNoCancel)
        if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
            $out = $Path + "new"
            try {
                $null = Process-Container -ExePath $wimlib -Arguments @('export', $Path, 'all', $out, '--compress=LZX', '--boot') -Activity "RecompressWIM" -Mode "Capture And Export"
            } catch {
                Set-Progress "RecompressWIM" "Errored" 100
                Error "RecompressWIM failed.`n$_"
            }
            if ($LASTEXITCODE -eq 0) {
                Remove-Item $Path -Force
                Rename-Item -Path $out -NewName $Path
            }
        } elseif ($result -eq [System.Windows.Forms.DialogResult]::Cancel) {
            Error "Operation cancelled."
        } else {
            try {
                $null = Process-Container -ExePath $wimlib -Arguments @('optimize', $Path, '--compress=LZX') -Activity "RecompressWIM" -Mode "Capture And Export"
            } catch {
                Set-Progress "RecompressWIM" "Errored" 100
                Error "RecompressWIM failed.`n$_"
            }
        }
        Complete-Progress "RecompressWIM"
    }
    # Recompress ESD operation. Used to optimise the size of the ESD file.
    'RecompressESD' {
        Set-Progress "RecompressESD" "Optimising/compressing ESD" 50
        $result = Question -msg "Is this ESD a boot image that requires re-export?" -Buttons ([System.Windows.Forms.MessageBoxButtons]::YesNoCancel)
        if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
            Write-Warning $CompressWarn
            $out = $Path + "new"
            try {
                $null = Process-Container -ExePath $wimlib -Arguments @('export', $Path, 'all', $out, '--compress=LZMS', '--boot') -Activity "RecompressESD" -Mode "Capture And Export"
            } catch {
                Set-Progress "RecompressESD" "Errored" 100
                Error "RecompressESD failed.`n$_"
            }
            if ($LASTEXITCODE -eq 0) {
                Remove-Item $Path -Force
                Rename-Item -Path $out -NewName $Path
            }
        } elseif ($result -eq [System.Windows.Forms.DialogResult]::Cancel) {
            Error "Operation cancelled."
        } else {
            try {
                $null = Process-Container -ExePath $wimlib -Arguments @('optimize', $Path, '--compress=LZMS') -Activity "RecompressESD" -Mode "Capture And Export"
            } catch {
                Set-Progress "RecompressESD" "Errored" 100
                Error "RecompressESD failed.`n$_"
            }
        }
        Complete-Progress "RecompressESD"
    }
    # Convert to WIM operation. Used to convert ESD input to WIM output.
    'ConvertToWIM' {
        Set-Progress "ConvertToWIM" "Choosing destination" 10
        $dest = Pick-SaveFile "WIM (*.wim)|*.wim" "$base.wim"
        $ConvertArgs = @('export', $Path, 'all', $dest, '--compress=LZX')
        $Answer = Question "Do you want your wimfile to remain bootable?" YesNoCancel
        if ($Answer -ieq "Yes") { $ConvertArgs += '--boot' } elseif ($Answer -ieq "No") { Write-Host $null } else { Error "Operation cancelled." }
        Set-Progress "ConvertToWIM" "Converting to WIM" 50
        try {
            $null = Process-Container -ExePath $wimlib -Arguments $ConvertArgs -Activity "ConvertToWIM" -Mode "Capture And Export"
        } catch {
            Set-Progress "ConvertToWIM" "Errored" 100
            Error "ConvertToWIM failed.`n$_"
        }
        Set-Progress "ConvertToWIM" "Deleting source file..." 80
        Remove-Item -Path $Path -Force
        Complete-Progress "ConvertToWIM"
    }
    # Convert to ESD operation. Used to convert WIM input to ESD output.
    'ConvertToESD' {
        Set-Progress "ConvertToESD" "Choosing destination" 50
        $dest = Pick-SaveFile "ESD (*.esd)|*.esd" "$base.esd"
        Write-Warning $CompressWarn
        $ConvertArgs = @('export', $Path, 'all', $dest, '--compress=LZMS', '--solid')
        $Answer = Question "Do you want your esdfile to remain bootable?" YesNoCancel
        if ($Answer -ieq "Yes") { $ConvertArgs += '--boot' } elseif ($Answer -ieq "No") { Write-Host $null } else { Error "Operation cancelled." }
        Set-Progress "ConvertToESD" "Converting to ESD" 70
        try {
            $null = Process-Container -ExePath $wimlib -Arguments $ConvertArgs -Activity "ConvertToESD" -Mode "Capture And Export"
        } catch {
            Set-Progress "ConvertToESD" "Errored" 100
            Error "ConvertToESD failed.`n$_"
        }
        Set-Progress "ConvertToESD" "Deleting source file..." 80
        Remove-Item -Path $Path -Force
        Complete-Progress "ConvertToESD"
    }
    # Delete image operation. Used to delete an image from a wimfile.
    'DeleteImage' {
        Set-Progress "DeleteImage" "Validating file extension" 5
        $ext = [IO.Path]::GetExtension($Path).ToLowerInvariant()
        if ($ext -in '.esd', '.swm') { Error "Files with extension '$ext' are read-only. Delete operation is impossible on ESD or SWM files due to how they are created." }
        Set-Progress "DeleteImage" "Selecting indices" 15
        $selected = Pick-Index -Path $Path -MultipleImages
        if ($null -eq $selected) { Error "No indices selected." }
        if ($selected -is [System.Array]) { $indices = $selected | ForEach-Object { [int]$_ } } else { $indices = @([int]$selected) }
        if (-not $indices) { Error "No indices selected." }
        $indices = $indices | Sort-Object -Descending
        $total = $indices.Count
        $response = Question "Do you want to proceed? You cannot reverse this action!"
        if ($response -ne "Yes") { Error "You cancelled the operation." }
        $i = 0
        foreach ($idx in $indices) {
            $i++
            $pct = [int](($i / $total) * 90)
            Write-Host "Deleting index $idx from ${Path}..."
            Set-Progress "DeleteImage" "Deleting index $idx ($i of $total)" $pct
            try { $null = Process-Container -ExePath $wimlib -Arguments @('delete', $Path, $idx) -Activity $Op -Mode "Capture And Export" } catch { Error $($_.Exception.Message) }
            if ($LASTEXITCODE -ne 0) {
                Set-Progress "DeleteImage" "Errored at index $idx" 100
                Error "Delete failed for index $idx.`n$raw"
            }
        }
        Set-Progress "DeleteImage" "Finalising" 95
        Info "Deletion complete."
        Complete-Progress "DeleteImage"
    }
    # Create ISO operation. Used to generate a bootable ISO from an official ESD source. 
    'CreateISOWIM' {
        $ext = [IO.Path]::GetExtension($Path).ToLowerInvariant()
        if ($ext -ne '.esd') { Error "CreateISOWIM only supports ESD input files. Provided: $ext" }
        $dirWim = Join-Path $WorkingDir "isocreator\wim\ISOFOLDER"
        if (Test-Path -LiteralPath $dirWim) { Remove-Item -Path $dirWim -Recurse -Force }
        $exeWim = Join-Path $WorkingDir "isocreator\wim\createisowim.exe"
        if (-not (Test-Path -LiteralPath $exeWim)) { Error "Required executable not found: $exeWim`r`nPlease install the ISO creator or adjust the path." }
        try {
            Set-Progress "CreateISOWIM" "Creating ISO file..." 50
            $raw = & "$exeWim" "$Path" 2>&1
            $exit = $LASTEXITCODE
        } catch {
            Error "Errored to start createisowim.exe: `n$($_.Exception.Message)"
        }
        if ($exit -eq 0 -and (Test-Path "$env:USERPROFILE\Desktop\$base.iso")) {
            Complete-Progress "CreateISOWIM"
            Info "ISO creation completed successfully.`r`nExit code: $exit"
        } else {
            Set-Progress "CreateISOWIM" "ISO creation failed" 100
            $msg = "createisowim.exe returned exit code $exit.`r`n`r`nOutput:`n$raw"
            Error $msg
        }
    }
    'CreateISOESD' {
        $ext = [IO.Path]::GetExtension($Path).ToLowerInvariant()
        if ($ext -ne '.esd') { Error "CreateISOESD only supports ESD input files. Provided: $ext" }
        $dirEsd = Join-Path $WorkingDir "isocreator\esd\ISOFOLDER"
        if (Test-Path -LiteralPath $dirEsd) { Remove-Item -Path $dirEsd -Recurse -Force }
        $exeEsd = Join-Path $WorkingDir "isocreator\esd\createisoesd.exe"
        if (-not (Test-Path -LiteralPath $exeEsd)) { Error "Required executable not found: $exeEsd`r`nPlease install the ISO creator or adjust the path." }
        try {
            Set-Progress "CreateISOESD" "Creating ISO file..." 50
            $raw = & "$exeEsd" "$Path" 2>&1
            $exit = $LASTEXITCODE
        } catch {
            Error "Errored to start createisoesd.exe: `n$($_.Exception.Message)"
        }
        if ($exit -eq 0 -and (Test-Path "$env:USERPROFILE\Desktop\$base.iso")) {
            Complete-Progress "CreateISOESD"
            Info "ISO creation completed successfully.`r`nExit code: $exit"
        } else {
            Set-Progress "CreateISOESD" "ISO creation failed" 100
            $msg = "createisoesd.exe returned exit code $exit.`r`n`r`nOutput:`r`n$raw"
            Error $msg
        }
    }
    'ExtractWIM' {
        Extract-ISO -Path $Path -Extension 'wim' -WorkingDir $WorkingDir -SetProgress ${function:Set-Progress} -CompleteProgress ${function:Complete-Progress} -Info ${function:Info} -Error ${function:Error}
    }
    'ExtractESD' {
        Extract-ISO -Path $Path -Extension 'esd' -WorkingDir $WorkingDir -SetProgress ${function:Set-Progress} -CompleteProgress ${function:Complete-Progress} -Info ${function:Info} -Error ${function:Error}
    }
    'ExtractSWM' {
        Extract-ISO -Path $Path -Extension 'swm' -WorkingDir $WorkingDir -SetProgress ${function:Set-Progress} -CompleteProgress ${function:Complete-Progress} -Info ${function:Info} -Error ${function:Error}
    }
    'SaveWIM' {
        Info "You can choose to save a drive into a new wimfile. If you close the dialog, you can choose to save a drive into an existing wimfile."
        Set-Progress "SaveWIM" "Choosing destination WIM" 15
        $default = "$base.wim"
        $dest = Pick-SaveFile "WIM (*.wim)|*.wim" $default
        if ([string]::IsNullOrWhiteSpace($dest)) {
            $default = "$base.wim"
            $dest = Pick-OpenFile "WIM (*.wim)|*.wim" $default
            if ([string]::IsNullOrWhiteSpace($dest)) {
                Error "Operation cancelled."
            } else {
                $n = Read-Host "Enter the name of the new image."
                $d = Read-Host "Enter the description of the new image."
                $parameters = @('append', $Path, $dest, $n, $d, '--compress=LZX')
                $action = "Appending"
            }
        } else {
            $n = Read-Host "Enter the name of the new image."
            $d = Read-Host "Enter the description of the new image."
            $parameters = @('capture', $Path, $dest, $n, $d, '--compress=LZX')
            $action = "Capturing"
        }
        $wimexe = $wimlib
        $where = "to"
        Set-Progress "SaveWIM" "Testing paths..." 30
        if (-not (Test-Path -LiteralPath $wimexe) -and (Get-Command 'wimlib-imagex.exe' -ErrorAction SilentlyContinue)) { $wimexe = (Get-Command 'wimlib-imagex.exe').Source }
        if (-not (Test-Path -LiteralPath $wimexe)) { $wimexe = Join-Path $WorkingDir "bin\wimlib-imagex.exe" }
        if (-not (Test-Path -LiteralPath $wimexe)) { Error "A dependency (wimlib-imagex.exe) is missing." }
        Set-Progress "SaveWIM" "$action $Path $where ${dest}..." 60
        try { $null = Process-Container -ExePath $wimexe -Arguments $parameters -Activity "SaveWIM" -Mode "Capture And Export" } catch { Error "The operation failed.`n$_" }
        Complete-Progress "SaveWIM"
        Info "WIM saved:`n$dest"
    }
    'SaveESD' {
        Info "You can choose to save a drive into a new esdfile. If you close the dialog, this operation will abort."
        Set-Progress "SaveESD" "Choosing destination ESD" 15
        $default = "$base.esd"
        $dest = Pick-SaveFile "ESD (*.esd)|*.esd" $default
        if ([string]::IsNullOrWhiteSpace($dest)) {
            Error "Operation cancelled."
        } else {
            $n = Read-Host "Enter the name of the new image."
            $d = Read-Host "Enter the description of the new image."
            $parameters = @('capture', $Path, $dest, $n, $d, '--compress=LZMS', '--solid')
            $action = "Capturing"
        }
        $esdexe = $wimlib
        $where = "to"
        Set-Progress "SaveESD" "Testing paths..." 30
        if (-not (Test-Path -LiteralPath $esdexe) -and (Get-Command 'wimlib-imagex.exe' -ErrorAction SilentlyContinue)) { $esdexe = (Get-Command 'wimlib-imagex.exe').Source }
        if (-not (Test-Path -LiteralPath $esdexe)) { $esdexe = Join-Path $WorkingDir "bin\wimlib-imagex.exe" }
        if (-not (Test-Path -LiteralPath $esdexe)) { Error "A dependency (wimlib-imagex.exe) is missing." }
        Write-Warning $CompressWarn
        Set-Progress "SaveESD" "$action $Path $where ${dest}..." 60
        try { $null = Process-Container -ExePath $esdexe -Arguments $parameters -Activity "SaveESD" -Mode "Capture And Export" } catch { Error "The operation failed.`n$_" }
        Complete-Progress "SaveESD"
        Info "ESD saved:`n$dest"
    }
    'SaveSWM' {
        Info "You can choose to save a drive into a new split wimfile. If you close the dialog, this operation will abort."
        Set-Progress "SaveSWM" "Choosing destination Split WIM" 15
        $default = "$base.swm"
        $dest = Pick-SaveFile "SWM (*.swm)|*.swm" $default
        if ([string]::IsNullOrWhiteSpace($dest)) {
            Error "Operation cancelled."
        } else {
            $t = [IO.Path]::GetFileNameWithoutExtension($dest)
            $tempfile = $t + ".wim"
            $n = Read-Host "Enter the name of the new image."
            $d = Read-Host "Enter the description of the new image."
            [uint16]$size = Read-Host "Enter split size."
            if ($size -gt 4092) { Warn "You will not be able to copy the split files onto any FAT32 volume!" }
            $first_parameters = @('capture', $Path, $tempfile, $n, $d, '--compress=LZX')
            $second_parameters = @('split', $tempfile, $dest, $size)
            $action = "Capturing"
        }
        $swmexe = $wimlib
        $where = "to"
        Set-Progress "SaveSWM" "Testing paths..." 30
        if (-not (Test-Path -LiteralPath $swmexe) -and (Get-Command 'wimlib-imagex.exe' -ErrorAction SilentlyContinue)) { $swmexe = (Get-Command 'wimlib-imagex.exe').Source }
        if (-not (Test-Path -LiteralPath $swmexe)) { $swmexe = Join-Path $WorkingDir "bin\wimlib-imagex.exe" }
        if (-not (Test-Path -LiteralPath $swmexe)) { Error "A dependency (wimlib-imagex.exe) is missing." }
        Set-Progress "SaveSWM" "Building temporary file... ($tempfile)" 45
        try { $null = Process-Container -ExePath $swmexe -Arguments $first_parameters -Activity "SaveSWM" -Mode "Capture And Export" } catch { Error "Capture to temp failed.`r`n$_" }
        Set-Progress "SaveSWM" "$action $Path $where ${dest}..." 60
        try { $null = Process-Container -ExePath $swmexe -Arguments $second_parameters -Activity "SaveSWM" -Mode "Split" } catch { Error "Split failed.`r`n$_" }
        if (Test-Path $tempfile) { Remove-Item $tempfile -Force }
        Complete-Progress "SaveSWM"
        Info "Split WIM saved:`r`n$dest"
    }
    'JoinWIM' {
        Info "You can join up a set of split wimfiles to a wimfile."
        $SplitWIM = $Path
        Set-Progress $Op "Building a list of split files based on the path..." 20
        [string[]]$Chunks = @(Get-SplitWimParts -SplitPart $SplitWIM)
        if ($Chunks.Count -lt 2) { Error "Only $($Chunks.Count) split part was found. Pick the first part of the split WIM set, or make sure the other .swm files are in the same folder." }
        Set-Progress $Op "Choosing final wimfile..." 40
        $Dest = Pick-SaveFile "WimFiles (*.wim)|*.wim"
        Set-Progress $Op "Joining $SplitWIM to ${Dest}..." 60
        $Success = $false
        try {
            $Args = @('join') + @($Dest) + $Chunks
            $null = Process-Container -ExePath $wimlib -Arguments $Args -Activity $Op -Mode "Capture And Export"
            Set-Progress $Op "Optimising your wimfile..." 80
            $OptArgs = @('optimize', $Dest, '--compress=LZX')
            $null = Process-Container -ExePath $wimlib -Arguments $OptArgs -Activity $Op -Mode "Capture And Export"
            $Success = $true
        } catch {
            Set-Progress $Op "Oh no. It failed." 100
            Remove-TemporaryWIM -Path $Dest
            Write-Error "Okay, I underestimated. Here is some error info:`r`n$($_.Exception.Message)" -ErrorAction Continue
        } finally {
            Complete-Progress $Op
        }
        if ($Success) { Info "Success! $SplitWIM has been exported to $Dest." }
    }
    'JoinESD' {
        Info "You can join up a set of split wimfiles to an esdfile."
        $SplitWIM = $Path
        Set-Progress $Op "Building a list of split files based on the path..." 20
        [string[]]$Chunks = @(Get-SplitWimParts -SplitPart $SplitWIM)
        if ($Chunks.Count -lt 2) { Error "Only $($Chunks.Count) split part was found. Pick the first part of the split WIM set, or make sure the other .swm files are in the same folder." }
        Set-Progress $Op "Choosing final esdfile..." 40
        $Dest = Pick-SaveFile "ESDFiles (*.esd)|*.esd"
        $TempWim = Join-Path $env:TEMP ("TEMPORARY_{0}.wim" -f ([guid]::NewGuid().ToString('N')))
        $Success = $false
        try {
            Set-Progress $Op "Joining $SplitWIM to a temporary WIM..." 60
            $JoinArgs = @('join') + @($TempWim) + $Chunks
            $null = Process-Container -ExePath $wimlib -Arguments $JoinArgs -Activity $Op -Mode "Capture And Export"
            Write-Warning $CompressWarn
            Set-Progress $Op "Converting your WIM into ESD format..." 80
            $ExportArgs = @('export', $TempWim, 'all', $Dest, '--compress=LZMS', '--solid')
            $null = Process-Container -ExePath $wimlib -Arguments $ExportArgs -Activity $Op -Mode "Capture And Export"
            $Success = $true
        } catch {
            Set-Progress $Op "Oh no. It failed." 100
            Remove-TemporaryWIM -Path $TempWim
            Remove-TemporaryWIM -Path $Dest
            Error "The conversion to ESD has failed! Here is some error info:`r`n$($_.Exception.Message)"
        } finally {
            Remove-TemporaryWIM -Path $TempWim
            Complete-Progress $Op
        }
        if ($Success) { Info "Success! $SplitWIM has been exported to $Dest." }
    }
    'ChangeBootIndexWIM' {
        if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { Error "Did you know that the file does not exist?:`r`n$Path" }
        if ([IO.Path]::GetExtension($Path) -ine '.wim') { Error "You can only use WIM files, not ESD or SWM.`r`n`r`nSelected: $Path" }
        Set-Progress $Op "Acquiring the WIM info..." 20
        $WimInfo = Acquire-WimInformation -WimPath $Path
        if ([uint32]$WimInfo.ImageCount -lt 1) { Error "NO IMAGES! Cannot select a boot image." }
        $CurrentBootIndex = [uint32]$WimInfo.BootIndex
        Write-Host "The current bootable image is ${CurrentBootIndex}."
        Write-Host "You have ${WimInfo.ImageCount} images in: ${Path}."
        Set-Progress $Op "Select the new bootable image index..." 50
        $NewBootIndex = [uint32](Pick-Index -Path $Path)
        if ($NewBootIndex -lt 1 -or $NewBootIndex -gt [uint32]$WimInfo.ImageCount) { Error "$NewBootIndex does not exist. It shall be in the range of (1-$($WimInfo.ImageCount))." }
        if ($NewBootIndex -eq $CurrentBootIndex) {
            Complete-Progress $Op
            Error "$NewBootIndex is already the bootable image that boots when you boot from this file!"
        }
        if ((Question "Are you sure you want to change the boot image?`r`n`r`nCurrent: ${CurrentBootIndex}`r`nNew: ${NewBootIndex}`r`n`r`nThis action can be undone afterwards." -Buttons ([System.Windows.Forms.MessageBoxButtons]::YesNo) -Icon ([System.Windows.Forms.MessageBoxIcon]::Question)) -ne [System.Windows.Forms.DialogResult]::Yes) {
            Complete-Progress $Op
            Error "You aborted. Nothing has ever happened. Sssshhhh..."
        }
        Set-Progress $Op "The bootable image will change from ${CurrentBootIndex} to ${NewBootIndex}..." 75
        $Verification = Set-WimBootIndex -WimPath $Path -Index $NewBootIndex
        Set-Progress $Op "Let me make sure it happened..." 95
        if ([uint32]$Verification.BootIndex -ne $NewBootIndex) { Error "The verification has failed!`r`n`r`nYou wanted ${NewBootIndex}`r`nReality: $($Verification.BootIndex)." }
        Complete-Progress $Op
        Info "Success! The WIM boot index has been changed from ${CurrentBootIndex} to ${NewBootIndex}.`r`n`r`nYour wimfile: $Path"
    }
    # This operation took almost 3 hours to get running properly.
    # Dozens of trial and errors after errors later and it works.
    'ChangeImageInfo' {
        if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { Error "Did you know that the file does not exist?:`r`n$Path" }
        if ([IO.Path]::GetExtension($Path) -ine '.wim') { Error "Sorry! This has to be a WIM file.`r`n`r`nSelected: $Path" }
        Set-Progress $Op "Getting WIM info!" 20
        $WimInfo = Acquire-WimInformation -WimPath $Path
        if ([uint32]$WimInfo.ImageCount -lt 1) { Error "Sorry! THERE ARE NO IMAGES. YOU CANNOT CHANGE IT." }
        Set-Progress $Op "OK. Pick an image." 40
        $Index = [uint32](Pick-Index -Path $Path)
        Set-Progress $Op "Acquire the metadata of ${Index}..." 55
        $Metadata = Get-WimImageMetadata -WimPath $Path -Index $Index
        $CurrentName = $Metadata.Name
        $CurrentDescription = $Metadata.Description
        $CurrentFlags = $Metadata.Flags
        Clear-Host
        $WinForm = New-Object System.Windows.Forms.Form
        $WinForm.Text = "WIM Information Changer - Index $Index"
        $WinForm.Width = 700
        $WinForm.Height = 330
        $WinForm.StartPosition = 'CenterScreen'
        $WinForm.FormBorderStyle = 'FixedDialog'
        $WinForm.MaximizeBox = $false
        $WinForm.MinimizeBox = $false
        $WinForm.Padding = '10,10,10,10'
        $WinForm.Font = New-Object System.Drawing.Font('Segoe UI',9)
        $Table = New-Object System.Windows.Forms.TableLayoutPanel
        $Table.Dock = 'Fill'
        $Table.ColumnCount = 2
        $Table.RowCount = 6
        $Table.ColumnStyles.Add((New-Object System.Windows.Forms.ColumnStyle([System.Windows.Forms.SizeType]::Absolute,130)))
        $Table.ColumnStyles.Add((New-Object System.Windows.Forms.ColumnStyle([System.Windows.Forms.SizeType]::Percent,100)))
        for ($r = 0; $r -lt 6; $r++) { $Table.RowStyles.Add((New-Object System.Windows.Forms.RowStyle([System.Windows.Forms.SizeType]::AutoSize))) }
        $labels = @('Image index:', 'Name:', 'Description:', 'Flags:', '')
        $IndexLabel = New-Object System.Windows.Forms.Label
        $IndexLabel.Text = "$Index"
        $IndexLabel.AutoSize = $true
        $NameLabel = New-Object System.Windows.Forms.Label
        $NameLabel.Text = 'Name:'
        $NameLabel.AutoSize = $true
        $DescLabel = New-Object System.Windows.Forms.Label
        $DescLabel.Text = 'Description:'
        $DescLabel.AutoSize = $true
        $FlagsLabel = New-Object System.Windows.Forms.Label
        $FlagsLabel.Text = 'Flags:'
        $FlagsLabel.AutoSize = $true
        $NameBox = New-Object System.Windows.Forms.TextBox
        $NameBox.Dock = 'Fill'
        $NameBox.Text = $CurrentName
        $DescBox = New-Object System.Windows.Forms.TextBox
        $DescBox.Dock = 'Fill'
        $DescBox.Text = $CurrentDescription
        $FlagsBox = New-Object System.Windows.Forms.TextBox
        $FlagsBox.Dock = 'Fill'
        $FlagsBox.Text = $CurrentFlags
        $Hint = New-Object System.Windows.Forms.Label
        $Hint.Text = 'You need to edit the above values. This will then change the metadata of your wimfile. Editing name and description also edits the display name and display description.'
        $Hint.AutoSize = $true
        $Hint.MaximumSize = New-Object System.Drawing.Size(520,0)
        $Buttons = New-Object System.Windows.Forms.FlowLayoutPanel
        $Buttons.Dock = 'Fill'
        $Buttons.FlowDirection = 'RightToLeft'
        $Buttons.AutoSize = $true
        $OK = New-Object System.Windows.Forms.Button
        $OK.Text = 'Apply'
        $OK.Width = 90
        $OK.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $Cancel = New-Object System.Windows.Forms.Button
        $Cancel.Text = 'Cancel'
        $Cancel.Width = 90
        $Cancel.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
        $Buttons.Controls.Add($OK)
        $Buttons.Controls.Add($Cancel)
        $Table.Controls.Add($IndexLabel,0,0)
        $Table.Controls.Add((New-Object System.Windows.Forms.Label),0,1)
        $Table.GetControlFromPosition(0,1).Text = 'Name:'
        $Table.GetControlFromPosition(0,1).AutoSize = $true
        $Table.Controls.Add($NameBox,1,1)
        $Table.Controls.Add($DescLabel,0,2)
        $Table.Controls.Add($DescBox,1,2)
        $Table.Controls.Add($FlagsLabel,0,3)
        $Table.Controls.Add($FlagsBox,1,3)
        $Table.Controls.Add($Hint,0,4)
        $Table.SetColumnSpan($Hint,2)
        $Table.Controls.Add($Buttons,0,5)
        $Table.SetColumnSpan($Buttons,2)
        $WinForm.Controls.Add($Table)
        $WinForm.AcceptButton = $OK
        $WinForm.CancelButton = $Cancel
        $theme = Is-LightModeOn
        if ($theme.Apps) { Enable-DarkMode $WinForm }
        Set-Progress $Op "Edit the metadata." 60
        Clear-Host
        if ($WinForm.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) { Error "Sorry! You (${env:USERNAME}) cancelled the operation." }
        if ([string]::IsNullOrWhiteSpace($NameBox.Text)) { Error "Sorry! No empty names please!" }
        if ((Question "Confirm that you want to change the metadata of ${Index}.`r`n`r`nName: $CurrentName -> $($NameBox.Text)`r`nDescription: $CurrentDescription -> $($DescBox.Text)`r`nFlags: $CurrentFlags -> $($FlagsBox.Text)`r`n`r`nThis modifies the WIM in-place." -Buttons ([System.Windows.Forms.MessageBoxButtons]::YesNo) -Icon ([System.Windows.Forms.MessageBoxIcon]::Question)) -ne [System.Windows.Forms.DialogResult]::Yes) { Error "Nevermind then..." }
        Set-Progress $Op "Changes are applying..." 80
        Set-WimImageMetadata -WimPath $Path -Index $Index -Name $NameBox.Text -Description $DescBox.Text -Flags $FlagsBox.Text
        Set-Progress $Op "We will confirm the changes." 95
        $Verify = Get-WimImageMetadata -WimPath $Path -Index $Index
        Clear-Host
        $ExpectedName = [string]$NameBox.Text
        $ExpectedDescription = [string]$DescBox.Text
        $ExpectedFlags = [string]$FlagsBox.Text
        if ($Verify.Name -cne $ExpectedName) { Error "WIM verification failed for NAME.`r`n`r`nExpected: [$ExpectedName]`r`nActual: [$($Verify.Name)]" }
        if ($Verify.DisplayName -cne $ExpectedName) { Error "WIM verification failed for DISPLAYNAME.`r`n`r`nExpected: [$ExpectedName]`r`nActual: [$($Verify.DisplayName)]" }
        if ($Verify.Description -cne $ExpectedDescription) { Error "WIM verification failed for DESCRIPTION.`r`n`r`nExpected: [$ExpectedDescription]`r`nActual: [$($Verify.Description)]" }
        if ($Verify.DisplayDescription -cne $ExpectedDescription) { Error "WIM verification failed for DISPLAYDESCRIPTION.`r`n`r`nExpected: [$ExpectedDescription]`r`nActual: [$($Verify.DisplayDescription)]" }
        if ($Verify.Flags -cne $ExpectedFlags) { Error "WIM verification failed for FLAGS.`r`n`r`nExpected: [$ExpectedFlags]`r`nActual: [$($Verify.Flags)]" }
        Complete-Progress $Op
        Clear-Host
        Info "Success! We have changed image ${Index}'s properties!`r`n`r`nName: $($Verify.Name)`r`nDescription: $($Verify.Description)`r`nFlags: $($Verify.Flags)`r`n`r`nWIM: $Path"
    }
    'SetupProgram' {
        if ($Op -ceq "SetupProgram" -and $Path -cne "SetupProgram") { Error "The path also needs to be SetupProgram." }
        $PSExe = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\PowerShell.exe"
        $UninstallA = @"
Windows Registry Editor Version 5.00

; ================================================
; ALOS Image Tools Context Menu Removal
; ================================================

[-HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM]

[-HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD]

[-HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM]

[-HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO]

[-HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG]

[-HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools]

[-HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools]

[-HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools]

[HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32]
@=""

; ==========================================
; END OF CONTEXT MENU REGISTRY.
; ==========================================
"@
        $UninstallB = @"
Windows Registry Editor Version 5.00

; ================================================
; ALOS Image Tools Context Menu Removal
; ================================================

[-HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}]

[-HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM]

[-HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD]

[-HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM]

[-HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO]

[-HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG]

[-HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools]

[-HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools]

[-HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools]

; ==========================================
; END OF CONTEXT MENU REGISTRY.
; ==========================================
"@
        function Install-ALOSImageTools { 
            Clear-Host
            $PSExePath = $PSExe -replace '\\', '\\' # Use a regex to find \ and replace with \\ to escape \ in registry file.
            $ALOSImageTools_Skeleton = Read-Host "Enter the installation path or press ENTER to use the default directory of ${WorkingDir}." # Define the path.
            if ([string]::IsNullOrWhiteSpace($ALOSImageTools_Skeleton)) { $ALOSImageTools_Skeleton = $WorkingDir }
            $Root = $ALOSImageTools_Skeleton
            New-Item -ItemType Directory -Path $Root -Force | Out-Null # Create a directory.
            Write-Host "Installing ALOS Image Tools to ${Root}!!!" -ForegroundColor Yellow
            $ALOSImageToolsDir = $Root -replace '\\', '\\' # Use a regex to find \ and replace with \\ to escape \ in registry file.
            $ALOSImageTools = "$ALOSImageToolsDir\\ALOS-ImageTools.ps1" # Manually add 2 \ to compensate for the file path in the registry.
            $ModernUI = if ($WPFUI) { "Yes" } else { "No" } # Automatically install an extra parameter if the user launches setup with modern UI.
            $Registry_WF = @"
Windows Registry Editor Version 5.00

; ================================================
; ALOS Image Tools Context Menu Entries
; ================================================

; Enable classic context menu.
[HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32]
@=""

; ================================================
; WIM file submenu.
; ================================================

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM]
"MUIVerb"="ALOS Image Tools"
"SubCommands"=""
"HasLUAShield"=""
"AppliesTo"="System.FileExtension:\"wim\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\03Mount]
@="Mount Image"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\03Mount\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Mount -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\04Export]
"MUIVerb"="Export Images..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\04Export\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\04Export\shell\04ExportWIM]
@="To WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\04Export\shell\04ExportWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExportWIM -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\04Export\shell\05ExportESD]
@="To ESD"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\04Export\shell\05ExportESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExportESD -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\06RecompressWIM]
@="Recompress"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\06RecompressWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op RecompressWIM -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\09ConvertToESD]
@="Convert To ESD"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\09ConvertToESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ConvertToESD -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\10GetInfo]
"MUIVerb"="Get Info..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\10GetInfo\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\10GetInfo\shell\10AGetInfo]
@="With Hashes"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\10GetInfo\shell\10AGetInfo\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op GetInfo -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\10GetInfo\shell\10BGetInfo]
@="Without Hashes"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\10GetInfo\shell\10BGetInfo\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op GetInfo -Path \"%1\" -NoHashes"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\11AApply]
@="Apply Image"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\11AApply\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Apply -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\11BApply]
@="Install Windows"
"HasLUAShield"=""
"AppliesTo"="System.FileName:\"install.wim\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\11BApply\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Apply -Path \"%1\" -InstallingWindows"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\12SplitWIM]
@="Split WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\12SplitWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op SplitWIM -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\13DeleteImage]
@="Delete Image"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\13DeleteImage\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op DeleteImage -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\14ApplyAndDeleteImage]
@="Apply And Delete Image"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\14ApplyAndDeleteImage\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ApplyAndDeleteImage -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\26ChangeBootIndexWIM]
@="Change Bootable Image"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\26ChangeBootIndexWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ChangeBootIndexWIM -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\27ChangeImageInfo]
@="Change WIM Information"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\27ChangeImageInfo\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ChangeImageInfo -Path \"%1\""

; ================================================
; ESD file submenu.
; ================================================

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD]
"MUIVerb"="ALOS Image Tools"
"SubCommands"=""
"HasLUAShield"=""
"AppliesTo"="System.FileExtension:\"esd\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\04Export]
"MUIVerb"="Export Images..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\04Export\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\04Export\shell\04ExportWIM]
@="To WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\04Export\shell\04ExportWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExportWIM -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\04Export\shell\05ExportESD]
@="To ESD"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\04Export\shell\05ExportESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExportESD -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\07RecompressESD]
@="Recompress"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\07RecompressESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op RecompressESD -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\08ConvertToWIM]
@="Convert To WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\08ConvertToWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ConvertToWIM -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\10GetInfo]
"MUIVerb"="Get Info..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\10GetInfo\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\10GetInfo\shell\10AGetInfo]
@="With Hashes"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\10GetInfo\shell\10AGetInfo\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op GetInfo -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\10GetInfo\shell\10BGetInfo]
@="Without Hashes"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\10GetInfo\shell\10BGetInfo\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op GetInfo -Path \"%1\" -NoHashes"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\11AApply]
@="Apply Image"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\11AApply\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Apply -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\11BApply]
@="Install Windows"
"HasLUAShield"=""
"AppliesTo"="System.FileName:\"install.esd\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\11BApply\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Apply -Path \"%1\" -InstallingWindows"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\15CreateISO]
"MUIVerb"="Create ISO..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\15CreateISO\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\15CreateISO\shell\15CreateISOWIM]
@="With install.wim As Installation Source"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\15CreateISO\shell\15CreateISOWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op CreateISOWIM -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\15CreateISO\shell\16CreateISOESD]
@="With install.esd As Installation Source"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\15CreateISO\shell\16CreateISOESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op CreateISOESD -Path \"%1\""

; ================================================
; SWM file submenu.
; ================================================

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM]
"MUIVerb"="ALOS Image Tools"
"SubCommands"=""
"HasLUAShield"=""
"AppliesTo"="System.FileExtension:\"swm\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\10GetInfo]
"MUIVerb"="Get Info..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\10GetInfo\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\10GetInfo\shell\10AGetInfo]
@="With Hashes"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\10GetInfo\shell\10AGetInfo\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op GetInfo -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\10GetInfo\shell\10BGetInfo]
@="Without Hashes"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\10GetInfo\shell\10BGetInfo\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op GetInfo -Path \"%1\" -NoHashes"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\11AApply]
@="Apply Image"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\11AApply\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Apply -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\11BApply]
@="Install Windows"
"HasLUAShield"=""
"AppliesTo"="System.FileName:\"install.swm\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\11BApply\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Apply -Path \"%1\" -InstallingWindows"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\23Join]
"MUIVerb"="Join SWM..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\23Join\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\23Join\shell\23JoinWIM]
@="Into WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\23Join\shell\23JoinWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op JoinWIM -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\23Join\shell\24JoinESD]
@="Into ESD"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\23Join\shell\24JoinESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op JoinESD -Path \"%1\""

; ================================================
; ISO file submenu.
; ================================================

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO]
"MUIVerb"="ALOS Image Tools"
"SubCommands"=""
"HasLUAShield"=""
"AppliesTo"="System.FileExtension:\"iso\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell\Extract]
"MUIVerb"="Extract..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell\Extract\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell\Extract\shell\17ExtractWIM]
@="WIM from ISO"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell\Extract\shell\17ExtractWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExtractWIM -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell\Extract\shell\18ExtractESD]
@="ESD from ISO"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell\Extract\shell\18ExtractESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExtractESD -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell\Extract\shell\19ExtractSWM]
@="SWM from ISO"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell\Extract\shell\19ExtractSWM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExtractSWM -Path \"%1\""

; ================================================
; IMG file submenu.
; ================================================

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG]
"MUIVerb"="ALOS Image Tools"
"SubCommands"=""
"HasLUAShield"=""
"AppliesTo"="System.FileExtension:\"img\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell\Extract]
"MUIVerb"="Extract..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell\Extract\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell\Extract\shell\17ExtractWIM]
@="WIM from IMG"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell\Extract\shell\17ExtractWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExtractWIM -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell\Extract\shell\18ExtractESD]
@="ESD from IMG"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell\Extract\shell\18ExtractESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExtractESD -Path \"%1\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell\Extract\shell\19ExtractSWM]
@="SWM from IMG"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell\Extract\shell\19ExtractSWM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExtractSWM -Path \"%1\""

; ================================================
; Directory background operations.
; ================================================

[HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools]
"MUIVerb"="ALOS Image Tools"
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools\shell]
@=""

[HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools\shell\01Capture]
@="Capture to WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools\shell\01Capture\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Capture -Path \"%V\""

[HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools\shell\02Append]
@="Append to WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools\shell\02Append\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Append -Path \"%V\""

[HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools\shell\runas]
@="Cleanup WIM Mounts"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools\shell\runas\command]
@="dism.exe /cleanup-wim"

; ================================================
; Directory operations.
; ================================================

[HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools]
"MUIVerb"="ALOS Image Tools"
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools\shell]
@=""

[HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools\shell\01Capture]
@="Capture to WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools\shell\01Capture\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Capture -Path \"%V\""

[HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools\shell\02Append]
@="Append to WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools\shell\02Append\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Append -Path \"%V\""

[HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools\shell\runas]
@="Cleanup WIM Mounts"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools\shell\runas\command]
@="dism.exe /cleanup-wim"

; ================================================
; Drive operations.
; ================================================

[HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools]
"MUIVerb"="ALOS Image Tools"
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools\shell]
@=""

[HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools\shell\20SaveWIM]
@="Image Drive To WIM File"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools\shell\20SaveWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op SaveWIM -Path \"%1\""

[HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools\shell\21SaveESD]
@="Image Drive To ESD File"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools\shell\21SaveESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op SaveESD -Path \"%1\""

[HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools\shell\22SaveSWM]
@="Image Drive To SWM File"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools\shell\22SaveSWM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op SaveSWM -Path \"%1\""

; ==========================================
; END OF CONTEXT MENU REGISTRY.
; ==========================================
"@
            $Registry_WPF = @"
Windows Registry Editor Version 5.00

; ================================================
; ALOS Image Tools Context Menu Entries
; ================================================

; Enable classic context menu.
[HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32]
@=""

; ================================================
; WIM file submenu.
; ================================================

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM]
"MUIVerb"="ALOS Image Tools"
"SubCommands"=""
"HasLUAShield"=""
"AppliesTo"="System.FileExtension:\"wim\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\03Mount]
@="Mount Image"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\03Mount\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Mount -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\04Export]
"MUIVerb"="Export Images..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\04Export\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\04Export\shell\04ExportWIM]
@="To WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\04Export\shell\04ExportWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExportWIM -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\04Export\shell\05ExportESD]
@="To ESD"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\04Export\shell\05ExportESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExportESD -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\06RecompressWIM]
@="Recompress"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\06RecompressWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op RecompressWIM -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\09ConvertToESD]
@="Convert To ESD"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\09ConvertToESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ConvertToESD -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\10GetInfo]
"MUIVerb"="Get Info..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\10GetInfo\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\10GetInfo\shell\10AGetInfo]
@="With Hashes"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\10GetInfo\shell\10AGetInfo\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op GetInfo -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\10GetInfo\shell\10BGetInfo]
@="Without Hashes"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\10GetInfo\shell\10BGetInfo\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op GetInfo -Path \"%1\" -NoHashes -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\11AApply]
@="Apply Image"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\11AApply\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Apply -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\11BApply]
@="Install Windows"
"HasLUAShield"=""
"AppliesTo"="System.FileName:\"install.wim\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\11BApply\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Apply -Path \"%1\" -InstallingWindows -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\12SplitWIM]
@="Split WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\12SplitWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op SplitWIM -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\13DeleteImage]
@="Delete Image"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\13DeleteImage\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op DeleteImage -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\14ApplyAndDeleteImage]
@="Apply And Delete Image"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\14ApplyAndDeleteImage\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ApplyAndDeleteImage -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\26ChangeBootIndexWIM]
@="Change Bootable Image"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\26ChangeBootIndexWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ChangeBootIndexWIM -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\27ChangeImageInfo]
@="Change WIM Information"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_WIM\shell\27ChangeImageInfo\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ChangeImageInfo -Path \"%1\" -WPFUI"

; ================================================
; ESD file submenu.
; ================================================

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD]
"MUIVerb"="ALOS Image Tools"
"SubCommands"=""
"HasLUAShield"=""
"AppliesTo"="System.FileExtension:\"esd\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\04Export]
"MUIVerb"="Export Images..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\04Export\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\04Export\shell\04ExportWIM]
@="To WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\04Export\shell\04ExportWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExportWIM -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\04Export\shell\05ExportESD]
@="To ESD"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\04Export\shell\05ExportESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExportESD -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\07RecompressESD]
@="Recompress"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\07RecompressESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op RecompressESD -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\08ConvertToWIM]
@="Convert To WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\08ConvertToWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ConvertToWIM -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\10GetInfo]
"MUIVerb"="Get Info..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\10GetInfo\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\10GetInfo\shell\10AGetInfo]
@="With Hashes"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\10GetInfo\shell\10AGetInfo\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op GetInfo -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\10GetInfo\shell\10BGetInfo]
@="Without Hashes"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\10GetInfo\shell\10BGetInfo\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op GetInfo -Path \"%1\" -NoHashes -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\11AApply]
@="Apply Image"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\11AApply\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Apply -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\11BApply]
@="Install Windows"
"HasLUAShield"=""
"AppliesTo"="System.FileName:\"install.esd\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\11BApply\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Apply -Path \"%1\" -InstallingWindows -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\15CreateISO]
"MUIVerb"="Create ISO..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\15CreateISO\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\15CreateISO\shell\15CreateISOWIM]
@="With install.wim As Installation Source"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\15CreateISO\shell\15CreateISOWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op CreateISOWIM -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\15CreateISO\shell\16CreateISOESD]
@="With install.esd As Installation Source"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ESD\shell\15CreateISO\shell\16CreateISOESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op CreateISOESD -Path \"%1\" -WPFUI"

; ================================================
; SWM file submenu.
; ================================================

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM]
"MUIVerb"="ALOS Image Tools"
"SubCommands"=""
"HasLUAShield"=""
"AppliesTo"="System.FileExtension:\"swm\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\10GetInfo]
"MUIVerb"="Get Info..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\10GetInfo\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\10GetInfo\shell\10AGetInfo]
@="With Hashes"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\10GetInfo\shell\10AGetInfo\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op GetInfo -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\10GetInfo\shell\10BGetInfo]
@="Without Hashes"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\10GetInfo\shell\10BGetInfo\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op GetInfo -Path \"%1\" -NoHashes -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\11AApply]
@="Apply Image"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\11AApply\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Apply -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\11BApply]
@="Install Windows"
"HasLUAShield"=""
"AppliesTo"="System.FileName:\"install.swm\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\11BApply\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Apply -Path \"%1\" -InstallingWindows -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\23Join]
"MUIVerb"="Join SWM..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\23Join\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\23Join\shell\23JoinWIM]
@="Into WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\23Join\shell\23JoinWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op JoinWIM -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\23Join\shell\24JoinESD]
@="Into ESD"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_SWM\shell\23Join\shell\24JoinESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op JoinESD -Path \"%1\" -WPFUI"

; ================================================
; ISO file submenu.
; ================================================

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO]
"MUIVerb"="ALOS Image Tools"
"SubCommands"=""
"HasLUAShield"=""
"AppliesTo"="System.FileExtension:\"iso\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell\Extract]
"MUIVerb"="Extract..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell\Extract\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell\Extract\shell\17ExtractWIM]
@="WIM from ISO"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell\Extract\shell\17ExtractWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExtractWIM -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell\Extract\shell\18ExtractESD]
@="ESD from ISO"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell\Extract\shell\18ExtractESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExtractESD -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell\Extract\shell\19ExtractSWM]
@="SWM from ISO"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_ISO\shell\Extract\shell\19ExtractSWM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExtractSWM -Path \"%1\" -WPFUI"

; ================================================
; IMG file submenu.
; ================================================

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG]
"MUIVerb"="ALOS Image Tools"
"SubCommands"=""
"HasLUAShield"=""
"AppliesTo"="System.FileExtension:\"img\""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell\Extract]
"MUIVerb"="Extract..."
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell\Extract\shell]
@=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell\Extract\shell\17ExtractWIM]
@="WIM from IMG"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell\Extract\shell\17ExtractWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExtractWIM -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell\Extract\shell\18ExtractESD]
@="ESD from IMG"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell\Extract\shell\18ExtractESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExtractESD -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell\Extract\shell\19ExtractSWM]
@="SWM from IMG"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\*\shell\ALOSImageTools_IMG\shell\Extract\shell\19ExtractSWM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op ExtractSWM -Path \"%1\" -WPFUI"

; ================================================
; Directory background operations.
; ================================================

[HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools]
"MUIVerb"="ALOS Image Tools"
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools\shell]
@=""

[HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools\shell\01Capture]
@="Capture to WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools\shell\01Capture\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Capture -Path \"%V\" -WPFUI"

[HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools\shell\02Append]
@="Append to WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools\shell\02Append\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Append -Path \"%V\" -WPFUI"

[HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools\shell\runas]
@="Cleanup WIM Mounts"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Directory\Background\shell\ALOSImageTools\shell\runas\command]
@="dism.exe /cleanup-wim"

; ================================================
; Directory operations.
; ================================================

[HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools]
"MUIVerb"="ALOS Image Tools"
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools\shell]
@=""

[HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools\shell\01Capture]
@="Capture to WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools\shell\01Capture\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Capture -Path \"%V\" -WPFUI"

[HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools\shell\02Append]
@="Append to WIM"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools\shell\02Append\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op Append -Path \"%V\" -WPFUI"

[HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools\shell\runas]
@="Cleanup WIM Mounts"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Directory\shell\ALOSImageTools\shell\runas\command]
@="dism.exe /cleanup-wim"

; ================================================
; Drive operations.
; ================================================

[HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools]
"MUIVerb"="ALOS Image Tools"
"SubCommands"=""
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools\shell]
@=""

[HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools\shell\20SaveWIM]
@="Image Drive To WIM File"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools\shell\20SaveWIM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op SaveWIM -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools\shell\21SaveESD]
@="Image Drive To ESD File"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools\shell\21SaveESD\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op SaveESD -Path \"%1\" -WPFUI"

[HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools\shell\22SaveSWM]
@="Image Drive To SWM File"
"HasLUAShield"=""

[HKEY_CLASSES_ROOT\Drive\shell\ALOSImageTools\shell\22SaveSWM\command]
@="\"$PSExePath\" -NoProfile -NoLogo -STA -ExecutionPolicy Bypass -File \"$ALOSImageTools\" -Op SaveSWM -Path \"%1\" -WPFUI"

; ==========================================
; END OF CONTEXT MENU REGISTRY.
; ==========================================
"@
            $RegFile = Join-Path $env:TEMP 'ALOS-ImageTools.reg'
            try {
                $Registry = if ($ModernUI -eq "Yes") { $Registry_WPF } elseif ($ModernUI -eq "No") { $Registry_WF } else { return $false }
                Set-Content -LiteralPath $RegFile -Value $Registry -Encoding Unicode
                & reg.exe import $RegFile
                if ($LASTEXITCODE -gt 0) { Warn "Registry cannot be imported. Please try again."; Clear-Host; return $false }
                Remove-Item -LiteralPath $RegFile -Force -ErrorAction SilentlyContinue
                Write-Host "ALOS Image Tools context-menu entries installed." -ForegroundColor Green
                Stop-Process -Name explorer -Force | Out-Null
                Write-Host "`r`nNext steps are:`r`nGrabbing the files."
                $ZipPath = Join-Path $Root 'ALOS_Image_Tools.zip'
                $Files = @(
                    "bin\7z.dll"
                    "bin\7z.exe"
                    "bin\libwim-15.dll"
                    "bin\wimlib-imagex.exe"
                    "isocreator\esd\CreateISOESD.exe"
                    "isocreator\esd\bin\7z.dll"
                    "isocreator\esd\bin\7z.exe"
                    "isocreator\esd\bin\bcdedit.exe"
                    "isocreator\esd\bin\bfi.exe"
                    "isocreator\esd\bin\cdimage.exe"
                    "isocreator\esd\bin\esddecrypt.exe"
                    "isocreator\esd\bin\imagex.exe"
                    "isocreator\esd\bin\libwim-15.dll"
                    "isocreator\esd\bin\offlinereg.exe"
                    "isocreator\esd\bin\offreg.dll"
                    "isocreator\esd\bin\rawcopy.exe"
                    "isocreator\esd\bin\wim-update.txt"
                    "isocreator\esd\bin\wimlib-imagex.exe"
                    "isocreator\esd\bin\bin64\libwim-15.dll"
                    "isocreator\esd\bin\bin64\wimlib-imagex.exe"
                    "isocreator\wim\CreateISOWIM.exe"
                    "isocreator\wim\bin\7z.dll"
                    "isocreator\wim\bin\7z.exe"
                    "isocreator\wim\bin\bcdedit.exe"
                    "isocreator\wim\bin\bfi.exe"
                    "isocreator\wim\bin\cdimage.exe"
                    "isocreator\wim\bin\esddecrypt.exe"
                    "isocreator\wim\bin\imagex.exe"
                    "isocreator\wim\bin\libwim-15.dll"
                    "isocreator\wim\bin\offlinereg.exe"
                    "isocreator\wim\bin\offreg.dll"
                    "isocreator\wim\bin\rawcopy.exe"
                    "isocreator\wim\bin\wim-update.txt"
                    "isocreator\wim\bin\wimlib-imagex.exe"
                    "isocreator\wim\bin\bin64\libwim-15.dll"
                    "isocreator\wim\bin\bin64\wimlib-imagex.exe"
                    "regfiles\ALOS-ImageTools (Remove) (Retain Classic Menu).reg"
                    "regfiles\ALOS-ImageTools (Remove) (Revert To Modern Menu).reg"
                    "regfiles\ALOS-ImageTools.reg"
                )
                $PresentFiles = Get-ChildItem -LiteralPath $Root -Recurse -File -Force | ForEach-Object { $_.FullName.Substring($Root.Length + 1) }
                $Missing = $Files | Where-Object { $_ -notin $PresentFiles }
                if ($Missing) {
                    Write-Error "Missing files:`r`n$($Missing -join "`r`n")" -ErrorAction Continue
                    if (-not (Test-Path -LiteralPath $ZipPath)) {
                        Write-Warning "Archive not found. Downloading it now..."
                        Invoke-WebRequest -Uri "https://github.com/AaravLegendOS/alos-image-tools/raw/refs/heads/main/ALOS_Image_Tools.zip" -OutFile $ZipPath
                    }
                    $Hash = (Get-FileHash -LiteralPath $ZipPath -Algorithm SHA256).Hash.ToUpper()
                    if ($Hash -cne "38C4F562336BDEE743FD0527CE919DEF38667C20F6ED35C5C457AFCCD372FC8C") { Warn "SHA256 hash does not match. ($Hash)"; Clear-Host; return $false } # If the hash does not match, throw an error. An empty hash target always throws an error.
                    Expand-Archive -Path $ZipPath -DestinationPath $Root -Force
                }
                Write-Host "All files are present." -ForegroundColor Green
                if (Test-Path -LiteralPath $ZipPath) { Remove-Item -Path $ZipPath -Force }
                Clear-Host
                return $true
            } catch {
                Warn $_
                return $false
            }
        }
        function Uninstall-ALOSImageTools {
            Clear-Host
            Write-Host "=================================================================" -ForegroundColor Yellow
            Write-Host "Do you want to revert to the modern menu (If on Windows 11)?" -ForegroundColor Cyan
            Write-Host "1) Uninstall ALOS Image Tools but keep the classic context menu." -ForegroundColor Green
            Write-Host "2) Uninstall ALOS Image Tools and revert to modern context menu." -ForegroundColor Red
            Write-Host "=================================================================" -ForegroundColor Magenta
            [int]$choice = Read-Host "Enter 1 or 2."
            switch ($choice) { 1 { $UninstallFile = $UninstallA } 2 { $UninstallFile = $UninstallB } default { Clear-Host; return $false } }
            $UninstallRegistry = Join-Path $env:TEMP "ALOSImageTools_Uninstall.reg"
            Set-Content -Path $UninstallRegistry -Value $UninstallFile -Encoding Unicode
            & reg.exe import $UninstallRegistry
            if ($LASTEXITCODE -gt 0) { return $false }
            Remove-Item $UninstallRegistry -Force -ErrorAction Stop
            Write-Host "ALOS Image Tools context-menu entries removed." -ForegroundColor Green
            Stop-Process -Name explorer -Force
            Clear-Host
            return $true
        }
        if ($WPFUI) {
            $Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="ALOS Image Tools - Installer / Uninstaller ($PID)"
        Width="800"
        Height="500"
        WindowStartupLocation="CenterScreen"
        ResizeMode="CanResize"
        Background="{DynamicResource Bg}"
        Foreground="{DynamicResource TextBrushWhite}"
        FontFamily="Segoe UI"
        FontSize="12">
    <Window.Resources>
        <SolidColorBrush x:Key="Bg" Color="#FF000000"/>
        <SolidColorBrush x:Key="ControlBg" Color="#FF101010"/>
        <SolidColorBrush x:Key="BorderBrushDark" Color="#FF2A2A2A"/>
        <SolidColorBrush x:Key="TextBrushWhite" Color="#FFFFFFFF"/>
        <SolidColorBrush x:Key="ComboPopupBg" Color="#FF101010"/>
        <SolidColorBrush x:Key="ComboHoverBg" Color="#FF2A2A2A"/>
        <SolidColorBrush x:Key="ComboSelectedBg" Color="#FF3A3A3A"/>
        <Style TargetType="{x:Type Button}">
            <Setter Property="Background" Value="{DynamicResource ControlBg}"/>
            <Setter Property="Foreground" Value="{DynamicResource TextBrushWhite}"/>
            <Setter Property="BorderBrush" Value="{DynamicResource BorderBrushDark}"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Padding" Value="8,4"/>
            <Setter Property="Cursor" Value="Hand"/>
        </Style>
        <Style TargetType="{x:Type ComboBox}">
            <Setter Property="Background" Value="{DynamicResource ControlBg}"/>
            <Setter Property="Foreground" Value="{DynamicResource TextBrushWhite}"/>
            <Setter Property="BorderBrush" Value="{DynamicResource BorderBrushDark}"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Padding" Value="4,2"/>
            <Setter Property="HorizontalContentAlignment" Value="Stretch"/>
            <Setter Property="VerticalContentAlignment" Value="Center"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="{x:Type ComboBox}">
                        <Grid SnapsToDevicePixels="True">
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="24"/>
                            </Grid.ColumnDefinitions>
                            <Border Grid.ColumnSpan="2"
                                    Background="{TemplateBinding Background}"
                                    BorderBrush="{TemplateBinding BorderBrush}"
                                    BorderThickness="{TemplateBinding BorderThickness}"/>
                            <ContentPresenter x:Name="ContentSite"
                                              Grid.Column="0"
                                              Margin="6,2,2,2"
                                              VerticalAlignment="Center"
                                              HorizontalAlignment="Left"
                                              Content="{TemplateBinding SelectionBoxItem}"
                                              ContentTemplate="{TemplateBinding SelectionBoxItemTemplate}"
                                              ContentTemplateSelector="{TemplateBinding ItemTemplateSelector}"
                                              IsHitTestVisible="False"
                                              RecognizesAccessKey="True"/>
                            <ToggleButton Grid.Column="1"
                                          Focusable="False"
                                          ClickMode="Press"
                                          IsChecked="{Binding IsDropDownOpen, Mode=TwoWay, RelativeSource={RelativeSource TemplatedParent}}"
                                          Background="{TemplateBinding Background}"
                                          BorderBrush="{TemplateBinding BorderBrush}"
                                          BorderThickness="0">
                                <Grid Background="Transparent">
                                    <TextBlock Text="▾"
                                               HorizontalAlignment="Center"
                                               VerticalAlignment="Center"
                                               Foreground="{TemplateBinding Foreground}"
                                               FontSize="11"/>
                                </Grid>
                            </ToggleButton>
                            <Popup x:Name="PART_Popup"
                                   Placement="Bottom"
                                   IsOpen="{TemplateBinding IsDropDownOpen}"
                                   AllowsTransparency="True"
                                   Focusable="False"
                                   PopupAnimation="Slide">
                                <Border MinWidth="{TemplateBinding ActualWidth}"
                                        Background="{DynamicResource ComboPopupBg}"
                                        BorderBrush="{DynamicResource BorderBrushDark}"
                                        BorderThickness="1">
                                    <ScrollViewer Margin="0"
                                                  SnapsToDevicePixels="True"
                                                  CanContentScroll="True">
                                        <ItemsPresenter KeyboardNavigation.DirectionalNavigation="Contained"/>
                                    </ScrollViewer>
                                </Border>
                            </Popup>
                        </Grid>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
        <Style TargetType="{x:Type ComboBoxItem}">
            <Setter Property="Background" Value="{DynamicResource ComboPopupBg}"/>
            <Setter Property="Foreground" Value="{DynamicResource TextBrushWhite}"/>
            <Setter Property="Padding" Value="6,3"/>
            <Setter Property="HorizontalContentAlignment" Value="Stretch"/>
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="{DynamicResource ComboHoverBg}"/>
                </Trigger>
                <Trigger Property="IsHighlighted" Value="True">
                    <Setter Property="Background" Value="{DynamicResource ComboHoverBg}"/>
                </Trigger>
                <Trigger Property="IsSelected" Value="True">
                    <Setter Property="Background" Value="{DynamicResource ComboSelectedBg}"/>
                    <Setter Property="Foreground" Value="{DynamicResource TextBrushWhite}"/>
                </Trigger>
                <Trigger Property="IsEnabled" Value="False">
                    <Setter Property="Foreground" Value="#FF888888"/>
                </Trigger>
            </Style.Triggers>
        </Style>
        <Style TargetType="{x:Type TextBlock}">
            <Setter Property="Foreground" Value="{DynamicResource TextBrushWhite}"/>
        </Style>
    </Window.Resources>
    <Border Background="{DynamicResource Bg}"
            BorderBrush="{DynamicResource BorderBrushDark}"
            BorderThickness="1">
        <Grid Margin="18">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto" />
                <RowDefinition Height="Auto" />
                <RowDefinition Height="Auto" />
                <RowDefinition Height="Auto" />
                <RowDefinition Height="*" />
            </Grid.RowDefinitions>
            <Grid Grid.Row="0">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*" />
                    <ColumnDefinition Width="Auto" />
                </Grid.ColumnDefinitions>
                <TextBlock Text="/===========================\"
                           Foreground="Magenta"
                           FontSize="16"
                           Margin="0,0,0,4" />
                <ComboBox x:Name="ThemeComboBox"
                          Grid.Column="1"
                          Width="110"
                          Height="26"
                          Margin="0,0,0,4"
                          SelectedIndex="2"
                          VerticalAlignment="Top">
                    <ComboBoxItem Content="Dark Mode"/>
                    <ComboBoxItem Content="Light Mode"/>
                    <ComboBoxItem Content="Auto"/>
                </ComboBox>
            </Grid>
            <TextBlock Grid.Row="1"
                       Text="| ALOS Image Tools - Installer / Uninstaller |"
                       Foreground="Cyan"
                       FontSize="16"
                       Margin="0,0,0,4" />
            <TextBlock Grid.Row="2"
                       Text="\===========================/"
                       Foreground="Yellow"
                       FontSize="16"
                       Margin="0,0,0,14" />
            <StackPanel Grid.Row="3" Margin="0,0,0,12">
                <TextBlock Text="1: Install ALOS Image Tools" Foreground="LightGreen" Margin="0,0,0,4" />
                <TextBlock Text="2: Uninstall ALOS Image Tools" Foreground="LightCoral" Margin="0,0,0,4" />
                <TextBlock Text="3: Reinstall with latest registry entries." Foreground="LightSkyBlue" Margin="0,0,0,4" />
            </StackPanel>
            <DockPanel Grid.Row="4">
                <StackPanel DockPanel.Dock="Left" Width="290" Margin="0,0,12,0">
                    <StackPanel Orientation="Horizontal" Margin="0,16,0,0">
                        <Button x:Name="InstallButton"
                                Content="Install"
                                Width="90"
                                Height="30"
                                Margin="0,0,10,0" />
                        <Button x:Name="UninstallButton"
                                Content="Uninstall"
                                Width="90"
                                Height="30"
                                Margin="0,0,10,0" />
                        <Button x:Name="ReinstallButton"
                                Content="Reinstall"
                                Width="90"
                                Height="30"
                                Margin="0,0,10,0" />
                    </StackPanel>
                </StackPanel>
            </DockPanel>
        </Grid>
    </Border>
</Window>
"@
            function Get-SystemAppTheme {
                try {
                    $value = Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'AppsUseLightTheme' -ErrorAction Stop
                    if ($value -eq 0) { return 'Dark' }
                    return 'Light'
                } catch {
                    return 'Dark'
                }
            }
            function Get-ThemeColours {
                $Theme = if ($script:ThemeMode -eq 'Auto') { Get-SystemAppTheme } else { $script:ThemeMode }
                switch ($Theme) {
                    'Light' {
                        [pscustomobject]@{
                            Bg = '#FFFFFFFF'
                            ControlBg = '#FFFFFFFF'
                            BorderBrush = '#FFB8B8B8'
                            TextBrush = '#FF111111'
                            ComboPopupBg = '#FFFFFFFF'
                            ComboHoverBg = '#FFF0F0F0'
                            ComboSelectedBg = '#FFDADADA'
                        }
                    }
                    default {
                        [pscustomobject]@{
                            Bg = '#FF000000'
                            ControlBg = '#FF000000'
                            BorderBrush = '#FF2A2A2A'
                            TextBrush = '#FFFFFFFF'
                            ComboPopupBg = '#FF101010'
                            ComboHoverBg = '#FF2A2A2A'
                            ComboSelectedBg = '#FF3A3A3A'
                        }
                    }
               }
            }
            function Set-ThemeBrush {
                param(
                    [Parameter(Mandatory)]
                    [string]$Key,
                    [Parameter(Mandatory)]
                    [string]$Hex
                )
                $Window.Resources[$Key] = [System.Windows.Media.BrushConverter]::new().ConvertFromString($Hex)
            }
            function Apply-Theme {
                $Colours = Get-ThemeColours
                Set-ThemeBrush -Key 'Bg' -Hex $Colours.Bg
                Set-ThemeBrush -Key 'ControlBg' -Hex $Colours.ControlBg
                Set-ThemeBrush -Key 'BorderBrushDark' -Hex $Colours.BorderBrush
                Set-ThemeBrush -Key 'TextBrushWhite' -Hex $Colours.TextBrush
                Set-ThemeBrush -Key 'ComboPopupBg' -Hex $Colours.ComboPopupBg
                Set-ThemeBrush -Key 'ComboHoverBg' -Hex $Colours.ComboHoverBg
                Set-ThemeBrush -Key 'ComboSelectedBg' -Hex $Colours.ComboSelectedBg
                if ($Window) {
                    $Window.Background = $Window.Resources['Bg']
                    $Window.Foreground = $Window.Resources['TextBrushWhite']
                }
            }
            $StringReader = New-Object System.IO.StringReader($Xaml)
            $XmlReader = [System.Xml.XmlReader]::Create($StringReader)
            $Window = [Windows.Markup.XamlReader]::Load($XmlReader)
            $InstallButton = $Window.FindName('InstallButton')
            $UninstallButton = $Window.FindName('UninstallButton')
            $ReinstallButton = $Window.FindName('ReinstallButton')
            $ThemeComboBox = $Window.FindName('ThemeComboBox')
            $script:ThemeMode = 'Auto'
            Apply-Theme
            $ThemeComboBox.Add_SelectionChanged({
                switch ($ThemeComboBox.SelectedIndex) {
                    0 { $script:ThemeMode = 'Dark' }
                    1 { $script:ThemeMode = 'Light' }
                    2 { $script:ThemeMode = 'Auto' }
                }
                Apply-Theme
            })
            $InstallButton.Add_Click({ if (Install-ALOSImageTools) { Info 'Successful install.' } else { Warn 'Unsucessful install.' } })
            $UninstallButton.Add_Click({ if (Uninstall-ALOSImageTools) { Info 'Successful uninstall.' } else { Warn 'Unsuccessful uninstall.' } })
            $ReinstallButton.Add_Click({ if ((Uninstall-ALOSImageTools) -and (Install-ALOSImageTools)) { Info 'Successful reinstall.' } else { Warn 'Unsuccessful reinstall.' } })
            $Window.WindowState = [System.Windows.WindowState]::Normal
            $Window.ResizeMode = [System.Windows.ResizeMode]::CanResize
            [void]$Window.ShowDialog()
        } else {
            $Form = New-Object System.Windows.Forms.Form
            $Form.Text = "ALOS Image Tools - Installer / Uninstaller ($PID)"
            $Form.StartPosition = 'CenterScreen'
            $Form.Size = New-Object System.Drawing.Size(760, 430)
            $Form.FormBorderStyle = 'FixedDialog'
            $Form.MaximizeBox = $false
            $ThemeColours = Is-LightModeOn
            $Form.BackColor = if ($ThemeColours.Apps) { [System.Drawing.Color]::Black } else { [System.Drawing.Color]::White }
            $Form.ForeColor = if ($ThemeColours.Apps) { [System.Drawing.Color]::White } else { [System.Drawing.Color]::Black }
            $Form.Font = New-Object System.Drawing.Font('Segoe UI', 10)
            function New-Label {
                param(
                    [string]$Text,
                    [int]$X,
                    [int]$Y,
                    [System.Drawing.Color]$Color
                )
                $Label = New-Object System.Windows.Forms.Label
                $Label.AutoSize = $true
                $Label.Text = $Text
                $Label.ForeColor = $Color
                $Label.Location = New-Object System.Drawing.Point($X, $Y)
                return $Label
            }
            $TitleLabel1 = New-Label '/===========================\' 24 18 ([System.Drawing.Color]::Magenta)
            $TitleLabel2 = New-Label '| ALOS Image Tools - Installer / Uninstaller |' 24 46 ([System.Drawing.Color]::Cyan)
            $TitleLabel3 = New-Label '\===========================/' 24 74 ([System.Drawing.Color]::Yellow)
            $OptionLabel1 = New-Label '1: Install ALOS Image Tools' 40 124 ([System.Drawing.Color]::LightGreen)
            $OptionLabel2 = New-Label '2: Uninstall ALOS Image Tools' 40 154 ([System.Drawing.Color]::LightCoral)
            $OptionLabel3 = New-Label '3: Reinstall with latest registry entries.' 40 184 ([System.Drawing.Color]::LightSkyBlue)
            $PromptLabel = New-Label 'Please make a decision' 24 264 ([System.Drawing.Color]::Gainsboro)
            $InstallButton = New-Object System.Windows.Forms.Button
            $InstallButton.Text = 'Install'
            $InstallButton.Location = New-Object System.Drawing.Point(40, 310)
            $InstallButton.Size = New-Object System.Drawing.Size(90, 30)
            $InstallButton.BackColor = if ($ThemeColours.Apps) { [System.Drawing.Color]::Black } else { [System.Drawing.Color]::White }
            $InstallButton.ForeColor = if ($ThemeColours.Apps) { [System.Drawing.Color]::White } else { [System.Drawing.Color]::Black }
            $InstallButton.FlatStyle = 'Flat'
            $UninstallButton = New-Object System.Windows.Forms.Button
            $UninstallButton.Text = 'Uninstall'
            $UninstallButton.Location = New-Object System.Drawing.Point(140, 310)
            $UninstallButton.Size = New-Object System.Drawing.Size(90, 30)
            $UninstallButton.BackColor = if ($ThemeColours.Apps) { [System.Drawing.Color]::Black } else { [System.Drawing.Color]::White }
            $UninstallButton.ForeColor = if ($ThemeColours.Apps) { [System.Drawing.Color]::White } else { [System.Drawing.Color]::Black }
            $UninstallButton.FlatStyle = 'Flat'
            $ReinstallButton = New-Object System.Windows.Forms.Button
            $ReinstallButton.Text = 'Reinstall'
            $ReinstallButton.Location = New-Object System.Drawing.Point(240, 310)
            $ReinstallButton.Size = New-Object System.Drawing.Size(90, 30)
            $ReinstallButton.BackColor = if ($ThemeColours.Apps) { [System.Drawing.Color]::Black } else { [System.Drawing.Color]::White }
            $ReinstallButton.ForeColor = if ($ThemeColours.Apps) { [System.Drawing.Color]::White } else { [System.Drawing.Color]::Black }
            $ReinstallButton.FlatStyle = 'Flat'
            $InstallButton.Add_Click({ if (Install-ALOSImageTools) { Info 'Successful install.' } else { Warn 'Unsuccessful install.' } })
            $UninstallButton.Add_Click({ if (Uninstall-ALOSImageTools) { Info 'Successful uninstall.' } else { Warn 'Unsuccessful uninstall.' } })
            $ReinstallButton.Add_Click({ if ((Uninstall-ALOSImageTools) -and (Install-ALOSImageTools)) { Info 'Successful reinstall.' } else { Warn 'Unsuccessful reinstall.' } })
            $Form.Controls.AddRange(@(
                $TitleLabel1,
                $TitleLabel2,
                $TitleLabel3,
                $OptionLabel1,
                $OptionLabel2,
                $OptionLabel3,
                $PromptLabel,
                $InstallButton,
                $UninstallButton,
                $ReinstallButton
            ))
            [void]$Form.ShowDialog()
        }
    }
    default {
        # We can never get here. Pratically dead code due to ValidateSet at the top.
        Error "Unknown operation: $Op"
        Exit 9009
    }
}
# Finally, show the finished message (The function automatically exits).
Show-Finished
<#
    End of program. All credits on ALOS Image Tools goes to Aarav Katariya.
    Run either setup_wf.exe or setup_wpf.exe in the same folder or just
    execute this script without any arguments to launch setup.
    Made by Aarav Katariya with love and care...
    Line count: 4805
#>