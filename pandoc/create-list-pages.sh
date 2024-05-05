# Ce script génère la liste des fichiers Markdown triés par dossier parent et nom de fichier.

# On met toujours en premier le fichier index.md qui se trouve à la racine du répertoire
echo 'index.md' > files.txt
# Ensuite on met les fichiers à la racine puis les fichiers dans les dossiers et sous-dossiers
find . -maxdepth 1 -type f -name "*.md" -not -name "index.md" >> files.txt && find . -mindepth 2 -type f -name "*.md" >> files.txt

prev_dir=""
echo "<section class=\"general-toc\">" >> links.html
while read file; do
  # Nom du dossier parent
  dir="$(dirname "$file")"
  # Si le dossier parent est différent du précédent, on ajoute une section de titre
  if [ "$dir" != "$prev_dir" ]; then
    if [ -n "$prev_dir" ]; then
      echo "</ul>" >> links.html
    fi
	if [ "$dir" != "." ]; then
  		echo "<h3>${dir#./}</h3><ul>"  >> links.html
	else
		echo "<ul>"  >> links.html
	fi
  fi

  # On ajoute un lien à la liste

  # Si le fichier contient un titre de niveau 1 en markdown, on définit le nom du fichier par ce titre
  filename="$(grep -m 1 -e "^#\ " "${file}" | sed "s/^#\ //")"
  # Sinon on reprend le nom du fichier dans le répertoire
  if [ -z "$filename" ]; then
	filename=$(basename "${file}" .md)
  fi
  echo "<li><a href=\"$(echo "${file%.md}.html" | sed 's|./||')\">${filename}</a></li>" >> links.html

  prev_dir="$dir"
done < files.txt

# On ferme les balises HTML
echo "</ul></section>" >> links.html

# On supprime le fichier temporaire
rm files.txt
