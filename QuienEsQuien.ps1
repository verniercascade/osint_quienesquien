<#
   Título: Aplicación de PowerShell que hace un llamado a la API de Quien es Quien
   Fuente: https://www.quienesquien.wiki/
   Autor: Marcelino Joshua Campillo Arjon
   Version: 1.0
#>
 $selection = Read-Host "1. Autocompletado: Encuentra personas, contratos u organizaciones por una parte del nombre"`n"2. Personas: Encuentra los documentos relacionados a una persona"`n"3. Organizaciones: Encuentra los documentos relacionados a una organización"`n"4. Contratos: Encuentra los contratos relacionados a una entidad"`n"Selecciona el módulo que deseas consultar de la API Quien es Quien"
 switch ($selection)
 {
     '1' {
         '1. Autocompletado: Encuentra personas, contratos u organizaciones por una parte del nombre'
         $selection='autocomplete'
     } '2' {
         '2. Personas: Encuentra los documentos relacionados a una persona'
         $selection='persons'
     } '3' {
         '3. Organizaciones: Encuentra los documentos relacionados a una organización' #companies, institutions, societies
         $selection='companies'
     } 
     '4' { #Actualmente en desarrollo - 23 de octubre de 2020
         '4. Contratos: Encuentra los contratos relacionados a una entidad'
         $selection='contracts'
         $uri1='https://api.quienesquien.wiki/v2/csv/'
         $uri2='?sort=-compiledRelease.total_amount'
         $supplier = Read-Host "Ingresa el nombre del proveedor (ENTER si no deseas filtrar)"
            if ($supplier -ne '')
            {
                $supplier = $supplier.replace(' ' , '%2520')
                $supplier = $supplier.replace(',' , '""')
                $supplier= $supplier+"%2Fi"
                $uri2=$uri2+'&compiledRelease.awards.suppliers.name=%2F'+$supplier
            }
         $dependency = Read-Host "Ingresa el nombre de la dependencia (ENTER si no deseas filtrar)"
            if ($dependency -ne '')
            {
                
                $dependency = $dependency.replace(' ' , '%2520')
                $dependency = $dependency+"%2Fi"
                $dependency = $dependency.replace(',' , '""')
                $uri2=$uri2+'&compiledRelease.parties.memberOf.name=%2F'+$dependency
            }
         $file = Read-Host "Ingresa nombre de tu archivo para tus resultados (.csv)"     
         $path = Read-Host "Ingresa la carpeta donde la quieras guardar (sin \ al final)" 
     } 
     'q' {
         return
     }
 }
 Write-Host $uri1$selection$uri2
 Write-Host "$path\$file"
 Invoke-RestMethod -Uri "$uri1$selection$uri2" | Out-File "$path\$file" -Encoding unicode
 Invoke-Item $path