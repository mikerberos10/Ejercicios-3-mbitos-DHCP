# 1. Crear un nuevo ámbito DHCP llamado RedInterna con IPs de 192.168.100.10 a 192.168.100.100
Add-DhcpServerv4Scope -Name "RedInterna" -StartRange 192.168.100.10 -EndRange 192.168.100.100 -SubnetMask 255.255.255.0

# 2. Configurar la puerta de enlace predeterminada para el ámbito RedInterna como 192.168.100.1
Set-DhcpServerv4OptionValue -ScopeId 192.168.100.0 -Router 192.168.100.1

# 3. Agregar el servidor DNS 8.8.8.8 al ámbito RedInterna
Set-DhcpServerv4OptionValue -ScopeId 192.168.100.0 -DnsServer 8.8.8.8

# 4. Activar el ámbito RedInterna
Set-DhcpServerv4Scope -Name "RedInterna" -State Active

# 5. Ver todos los ámbitos DHCP configurados en el servidor
Get-DhcpServerv4Scope

# 6. Eliminar el ámbito llamado Antiguo (si existe)
if (Get-DhcpServerv4Scope -Name "Antiguo") {
    Remove-DhcpServerv4Scope -Name "Antiguo" -Force
}

# 7. Verificar los registros de concesión (leases) activos del ámbito RedInterna
Get-DhcpServerv4Lease -ScopeId 192.168.100.0

# 8. Reservar la IP 192.168.100.50 para el cliente con MAC 00-11-22-33-44-55
Add-DhcpServerv4Reservation -ScopeId 192.168.100.0 -IPAddress 192.168.100.50 -ClientId 00-11-22-33-44-55

# 9. Desactivar el ámbito RedInterna temporalmente
Set-DhcpServerv4Scope -Name "RedInterna" -State Inactive

# 10. Exportar la configuración del servidor DHCP a un archivo XML
Export-DhcpServer -FileName "C:\Ruta\De\Guardado\ConfiguracionDHCP.xml" -Path "C:\Ruta\De\Guardado"

