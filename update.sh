#!/bin/bash



git checkout master -- Drafts

cat start.html > index.html
rm content.html

cd Drafts

for FILE in `ls -l`
do
    if test -d $FILE
    then
      echo "Entering Directory: $FILE"
      cd $FILE
      for HTMLFILE in `ls *.html 2>/dev/null`
      do
          echo "Procsessing file: $HTMLFILE"
          echo "<h3> $FILE </h3>" >> ../../content.html
          echo "<p>" >> ../../content.html
          echo "${HTMLFILE%%.*} <a href=Drafts/$FILE/$HTMLFILE> [html] </a>" >> ../../content.html
          echo "<a href=Drafts/$FILE/${HTMLFILE%%.*}.txt> [txt] </a>" >> ../../content.html
          echo "<a href=Drafts/$FILE/${HTMLFILE%%.*}.raw.txt> [raw.txt] </a>" >> ../../content.html
          echo "</p>" >> ../../content.html
          

      done
      cd ..
    fi
done
cd ..

cat content.html >>index.html
cat end.html >>index.html

git add Drafts
git commit -a -m "Sync docs from master branch to docs gh-pages directory"


git push origin gh-pages