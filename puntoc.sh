
mkdir appHomeBanking
 echo "<html><body><h1>Banco Hipotecario</h1></body></html>" > /appHomeBanking/index.html
 echo "<html><body><h1>Banco Hipotecario contactanos</h1></body></html>" > /appHomeBanking/contacto.html

touch DockerFile

# Para habilitar el servicio de Docker para que se inicie automáticamente después de reiniciar
sudo systemctl enable --now docker

# Para comprobar si Docker está en ejecución
sudo systemctl status docker

#construyo imagen
docker build -t 2parcial-ayso:v1.0 .

#me logueo
docker login -u marcoslapira

#etiqueto imagen
docker tag 2parcial-ayso:v1.0 marcoslapira/2parcial-ayso:v1.0

#subo imagen 
docker push marcoslapira/2parcial-ayso:v1.0

# Nombre de la imagen en Docker Hub
docker pull marcoslapira/2parcial-ayso:v1.0

#corro imagen
http://192.168.56.3:8080/index.html
