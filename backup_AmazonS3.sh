#!/bin/bash

# Utilisation de set -e pour quitter en cas d'erreur
set -e

# Utilisation de set -u pour quitter si des variables non définies sont utilisées
set -u

# Définition des constantes
readonly SCRIPT_NAME=$(basename "$0")
readonly BUCKET_NAME="mon-bucket-s3"

# Fonction pour afficher l'aide
usage() {
    echo "Usage: $SCRIPT_NAME [-h] [-d directory]"
    echo "  -h                Afficher l'aide"
    echo "  -d directory      Spécifier le répertoire à sauvegarder"
    exit 1
}

# Vérification des dépendances
command -v aws >/dev/null 2>&1 || { echo "aws-cli est requis mais n'est pas installé. Abandon."; exit 1; }

# Traitement des options
while getopts "hd:" opt; do
    case $opt in
        h)
            usage
            ;;
        d)
            directory=$OPTARG
            ;;
        *)
            echo "Option invalide: -$OPTARG" >&2
            usage
            ;;
    esac
done

# Vérification si le répertoire est spécifié
if [[ -z "${directory:-}" ]]; then
    echo "Erreur : Répertoire non spécifié."
    usage
fi

# Vérification si le répertoire existe
if [[ ! -d "$directory" ]]; then
    echo "Erreur : Le répertoire spécifié n'existe pas."
    exit 1
fi

# Création d'un nom de fichier de sauvegarde unique basé sur la date et l'heure
backup_filename=$(date +"%Y%m%d%H%M%S").tar.gz

# Fonction pour effectuer la sauvegarde
backup_directory() {
    # Archivage et compression du répertoire
    tar -czf "$backup_filename" "$directory"
    
    # Transfert du fichier de sauvegarde vers Amazon S3
    aws s3 cp "$backup_filename" "s3://$BUCKET_NAME/"
    
    # Suppression du fichier de sauvegarde local
    rm -f "$backup_filename"
}

# Appel de la fonction de sauvegarde
backup_directory

# Message de succès
echo "Sauvegarde de $directory effectuée avec succès dans s3://$BUCKET_NAME/"
