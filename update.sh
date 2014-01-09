#!/bin/bash

#git checkout master -- Drafts
git pull
cp -r Drafts/* DraftStorage

cat start.html > index.html
rm content.html

cd DraftStorage
for FILE in `ls -l`
do
    if test -d $FILE
    then
      #echo "Entering Directory: $FILE"
      echo "<h3> $FILE </h3>" >> ../content.html
      cd $FILE
      for HTMLFILE in `ls *.html 2>/dev/null`
      do
          #echo "Procsessing file: $HTMLFILE"
          echo "<p>" >> ../../content.html
          echo "${HTMLFILE%%.*} <a href=DraftStorage/$FILE/$HTMLFILE> [html] </a>" >> ../../content.html
          echo "<a href=DraftStorage/$FILE/${HTMLFILE%%.*}.txt> [txt] </a>" >> ../../content.html
          echo "<a href=DraftStorage/$FILE/${HTMLFILE%%.*}.raw.txt> [raw.txt] </a>" >> ../../content.html
          echo "</p>" >> ../../content.html
      done
      cd ..
    fi
done
cd ..

cat content.html >>index.html
cat end.html >>index.html

git add DraftStorage
git commit -a -m "Sync generated drafs to gh-pages directory"
git push origin gh-pages
