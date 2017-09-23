"C:\Program Files\Eiffel Software\EiffelStudio 17.05 GPL\studio\spec\win64\bin\ec.exe" -finalize -config connexion.ecf -target test
cd EIFGENs\test\F_code
"C:\Program Files\Eiffel Software\EiffelStudio 17.05 GPL\studio\spec\win64\bin\finish_freezing.exe"
cd ..\..\..

"C:\Program Files\Eiffel Software\EiffelStudio 17.05 GPL\studio\spec\win64\bin\ec.exe" -finalize -config connexion.ecf -target connexion
cd EIFGENs\connexion\F_code
"C:\Program Files\Eiffel Software\EiffelStudio 17.05 GPL\studio\spec\win64\bin\finish_freezing.exe"
cd ..\..\..

copy /Y .\EIFGENs\connexion\F_code\connexion.exe
