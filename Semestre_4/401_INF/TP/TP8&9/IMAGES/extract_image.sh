#!/bin/bash

# 
# Usage : extract_image  your_image_file.bm
#
# Extract 
#   1) image_bits_contents.c 
#          contains bits array of content declaration
#          for inclusion in main.c
#   2) image_bits_include.h
#          défines WIDTH, HEIGHT, BYTES and BYTES_PER_LINE 
#          to be included in both .c and .S files
#

nom=`echo $1.bm | sed -e "s/\.bm\.bm/.bm/"`

if [ ! -s $nom ]; then
  echo "Le fichier image $1 est vide ou n'existe pas."
  exit 1
fi

if [ ! -r $nom ]; then
  echo "Le fichier image $1 n'est pas accessible en lecture."
  exit 1
fi

w=`grep "#define" $nom | grep "width"`
w=`echo $w | sed -e "s/^ *#define *//" | sed -e "s/width *//"`
w=`echo $w | sed -e "s/\(^[1-9][0-9]*\).*/\1/"`
ok=`echo $w |  grep "^[1-9][0-9]*" | wc -l`


if [ ! $ok -eq 1 ]; then
   echo "Erreur : #define width absent ou non conforme"
   exit 1
fi

h=`grep "#define" $nom | grep "height"`
h=`echo $h | sed -e "s/^ *#define *//" | sed -e "s/height *//"`
h=`echo $h | sed -e "s/\(^[1-9][0-9]*\).*/\1/"`
ok=`echo $h |  grep "^[1-9][0-9]*" | wc -l`

if [ ! $ok -eq 1 ]; then
   echo "Erreur : #define height absent ou non conforme"
   exit 1
fi

bytesperline=$(($w / 8))
bytes=$(( $bytesperline * $h ))

c_include="image_bits_include.h"

if ! echo "#define WIDTH $w" > $c_include 
then
   echo "Echec d'écriture de width dans $c_include"
   exit 1
fi

echo "#define HEIGHT $h" >> $c_include
echo "#define BYTES $bytes" >> $c_include
echo "#define BYTES_PER_LINE $bytesperline" >> $c_include

content="image_bits_content.c"
dollar='$'
cp $nom $content

# Edit in place image copy : remove preprocessor directives
sed -i -e "/^ *#/d" $content    


