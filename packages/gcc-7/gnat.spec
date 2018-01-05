# gnat
*link:
+ -L/data/data/com.termux/files/usr/lib -as-needed -lgnat -gnarl -no-as-needed  %{!nopie: %{!static: %{!shared: %{!nostdlib: %{!nostartfiles: %{!fno-PIE: %{!fno-pie: -pie}}}}}}}

