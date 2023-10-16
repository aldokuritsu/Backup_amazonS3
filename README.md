# Description
Script qui permet de créer une archive d'un dossier et de l'envoyer vers Amazon S3

# Pré-requis

Avoir installé aws-cli sur votre système. + d'infos ici : https://aws.amazon.com/fr/cli/

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

## Pour automatiser l'envoi du fichier avec une tâche cron, vous devrez suivre les étapes ci-dessous :

1. Ouvrez le fichier crontab :
Ouvrez le fichier crontab pour éditer les tâches programmées en utilisant la commande suivante :
```
crontab -e
```

2. Ajoutez une entrée pour votre script :
À la fin du fichier, ajoutez une nouvelle ligne pour votre script. Par exemple, pour exécuter votre script tous les jours à 2 heures du matin, vous pouvez ajouter la ligne suivante :
```
0 2 * * * /chemin/vers/votre/backup_script.sh -d /tmp/tutos
```
Remplacez /chemin/vers/votre/backup_script.sh par le chemin complet vers votre script.

La syntaxe de cette ligne est la suivante :
- 0 2 * * * : spécifie l'horaire. Dans ce cas, il est configuré pour exécuter la tâche à 2 heures du matin tous les jours.
- /chemin/vers/votre/backup_script.sh -d /tmp/tutos : est la commande à exécuter.

3. Sauvegardez et quittez l'éditeur :
Sauvegardez le fichier et quittez l'éditeur (la façon de faire dépendra de l'éditeur que vous utilisez, par exemple en appuyant sur CTRL + X puis Y et enfin Enter si vous utilisez nano).

4. Vérifiez votre crontab :
Vous pouvez vérifier que votre nouvelle tâche est correctement enregistrée en listant toutes vos tâches cron avec la commande suivante :
```
crontab -l
```

# Informations complémentaires
- Les options -h (pour afficher l'aide) et -d (pour spécifier le répertoire à sauvegarder) sont traitées à l'aide de getopts.
- Les vérifications sont effectuées pour s'assurer que le CLI AWS est installé et que le répertoire spécifié existe.
- Une fonction backup_directory est définie pour archiver et compresser le répertoire, puis pour transférer le fichier de sauvegarde vers Amazon S3.
- Le script utilise set -e et set -u pour gérer les erreurs de manière appropriée.
- Les variables et les fonctions sont nommées de manière descriptive.
- La constante BUCKET_NAME est définie en utilisant readonly pour stocker le nom du bucket S3.

