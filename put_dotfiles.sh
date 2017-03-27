#/bin/bash
date=`date +%Y%m%d-%k%M%S`

for file in files/*; do
    name=`basename ${file}`
    echo $name
    if [ ! -e ~/$name ]; then
      echo "$name exists"
      mkdir -p ~/backup
      cp -pr ~/.$name ~/backup/$name.$date
    else
      echo "$name not exists"
    fi
#    cp -pr $file ~/.$name
done

