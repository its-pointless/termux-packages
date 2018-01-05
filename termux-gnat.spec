# Android 5 requires position-independent executables, so we use the
#   %{!S:X}     Substitutes X, if the -S switch is not given to GCC"
# construct (see https://gcc.gnu.org/onlinedocs/gcc/Spec-Files.html for full reference)
# to add -fPIE and -pie flags as appropriate.

*cc1_options:
+ %{!fpie: %{!fPIE: %{!fpic: %{!fPIC: %{!fno-pic:-fPIE}}}}}

*cc1plus:
+ -I/data/data/com.termux/files/usr/include/c++/v1  %{!fpie: %{!fPIE: %{!fpic: %{!fPIC: %{!fno-pic:-fPIE}}}}}

*link:
+ -L/data/data/com.termux/files/usr/lib --as-needed  -lgnat --no-as-needed %{!nopie: %{!static: %{!shared: %{!nostdlib: %{!nostartfiles: %{!fno-PIE: %{!fno-pie: -pie}}}}}}} 
