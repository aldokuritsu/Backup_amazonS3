# Scripts-shell
Quelques scripts shells plus ou moins utiles

# Utilisation

Rendez le script exécutable avec la commande suivante :

```
chmod +x backup_script.sh
```
Exécutez le script avec l'option -d pour spécifier le répertoire  à sauvegarder.

Exemple : sauvegarder le répertoire "test" présent dans /tmp :

```
./backup_script.sh -d /tmp/test
```

Dans cette commande, -d est l'option que le script utilise pour accepter le chemin du répertoire à sauvegarder, et /tmp/tutos est la valeur que vous donnez à cette option. 
Le script archive ensuite le répertoire spécifié et le télécharge dans votre bucket Amazon S3.

Notez que le script doit avoir les permissions nécessaires pour lire le contenu du répertoire /tmp/tutos et écrire dans le répertoire où il est exécuté, car il crée temporairement un fichier d'archive avant de le télécharger sur Amazon S3.

# Informations complémentaires
- Les options -h (pour afficher l'aide) et -d (pour spécifier le répertoire à sauvegarder) sont traitées à l'aide de getopts.
- Les vérifications sont effectuées pour s'assurer que le CLI AWS est installé et que le répertoire spécifié existe.
- Une fonction backup_directory est définie pour archiver et compresser le répertoire, puis pour transférer le fichier de sauvegarde vers Amazon S3.
- Le script utilise set -e et set -u pour gérer les erreurs de manière appropriée.
- Les variables et les fonctions sont nommées de manière descriptive.
- La constante BUCKET_NAME est définie en utilisant readonly pour stocker le nom du bucket S3.

