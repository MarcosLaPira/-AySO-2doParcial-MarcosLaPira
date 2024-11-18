
lsblk

# Crear las particiones c
sudo fdisk /dev/sdc 
n   # Crear nueva partición primaria 1 (Swap)
p
1
+1G
t
82   # Tipo de partición (Linux Swap)

n   # partición primaria 2 (PV 1GB)
p
2
+1G

n   # partición primaria 3 (PV 1GB)
p
3
+1G

n   #  partición extendida
e
4

n   # partición lógica 1 PV
+1.5G

n   # lógica 2 PV
+1.3G

w   # Guardar 



#Convertir las particiones a Physical Volumes (PV)
sudo pvcreate /dev/sdc2  # PV de 1GB
sudo pvcreate /dev/sdc3  # PV de 1GB
sudo pvcreate /dev/sdc5  # PV de 1.5GB
sudo pvcreate /dev/sdc6  # PV de 1.3GB



#Crear los Volume Groups (VG)
sudo vgcreate vgAdmin /dev/sdc2 /dev/sdc3  # VG de 2GB
sudo vgcreate vgDevelopers /dev/sdc5 /dev/sdc6  # VG de 3GB

sudo lvcreate -L 1.8G -n Admin vgAdmin
sudo lvcreate -L 1G -n Developers vgDevelopers
sudo lvcreate -L 1G -n Testers vgDevelopers
sudo lvcreate -L 0.5G -n DevOps vgDevelopers

sudo mkswap /dev/sdc1  # Crear sistema de archivos Swap
sudo swapon /dev/sdc1  # Activar Swap



