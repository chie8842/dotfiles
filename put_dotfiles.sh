#/bin/bash
date=`date +%Y%m%d-%k%M%S`

for file in files/*; do
    name=`basename ${file}`
    echo $name
    if [ ! -e ~/$name ]; then
      echo "exists"
      mkdir -p ~/backup
      cp -r ~/.$name ~/backup/$name.$date
    else
      echo "not exists"
    fi
#    cp -r $file ~/.$name
done

