# Git

All the changes, must be done in the Dev branch, and then merge with the Main branch

```git
git → Show all commands
git init → Create repository
git clone → Clone repository
git add → To stagin area
git commit → Apply the changes
git status → See the status
git log → See all the commits
```

### Git config

```git
git config --global user.name "Luis Lerma"
git config --global user.email "luislerma..."

#To consult
git config --global user.name	

#Just to local project
git config user.name "Luis Lerma"	

#Help
git help config 	

#Show all config
git config --list 
```

### Other comands

ls → Sirve para listar los archivos y carpetas que hay dentro del directorio en el que estés

cd → Este comando sirve para cambiar de directorio; por ejemplo si estás en /home/directorio/ y quieres pasar a /home/directorio2/, tendrías que escribir: cd /home/directorio2/ Si quieres pasar a un directorio superior o regresar al directorio en el que te encontrabas, tendrías que escribir cd ..

mkdir → Este comando sirve para crear nuevos directorios; por ejemplo:mkdir nuevoDirectorio

rm → Si queremos borrar algún archivo o directorio podemos hacer uso del comando rm y el nombre del archivo que deseamos borrar; por ejemplo: rm archivo.txt Para borrar directorios es necesario usar el atributo -rf; por ejemplo: rm -rf /directorio/

### Ad and commit

https://www.youtube.com/watch?v=UJGKWMHX038&t=348s

```git
vim index.html → Create file, :x to exit

git add index.html → Add everything, then use :wq for the name of commit
git commit -m "Commit name" → Commit
```