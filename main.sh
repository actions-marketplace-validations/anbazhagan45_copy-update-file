#!/bin/bash -l

 

    # copy source file to target file

    # delete properties which are part of argument 3

    # add properties and respective values as key,vaue pair in target file

 

    set -euo pipefail

 

    main() {

 

      local templateFile="$1";

      local targetFile="$2"

      local keysString="$3";

      local valuesString="$4";

 

      SAVEIFS=$IFS       # Save current IFS (Internal Field Separator)

 

      createPropertyFile  "$templateFile" "$targetFile"

 

      # read and split keys by ","

      IFS=$',' read -r -a keys <<<"$keysString"

      # read and split keys by ","

      IFS=$',' read -r -a values <<<"$valuesString"

 

      unset IFS

 

      IFS=$SAVEIFS       # Restore original IFS

 

      local index=0;

      for i in "${keys[@]}"; do

        local key=${keys[index]}

        deleteProperty "$targetFile" "$key"

        local updatedProp="$i=${values[index]}"

        echo "$i=${values[index]}" >> $targetFile #add property into file

        index=$index+1

      done

    }

 

    deleteProperty() {

      # echo "delete called: ${1} - ${2}"

      local prop="$2"

      local targetFile="$1"

      sed -i '/'${prop}'/d' $targetFile

    }

 

    createPropertyFile() {

      # input might contains spaces and other characters

      local templateFile="$1"

      local targetFile="$2"

 

      # extract the file + dir names

      templateFileName="`basename "${templateFile}"`"

      templateDir="`dirname "${templateFile}"`"

 

      # create the dir, then the file

      # mkdir -p "${DIR}" && touch "${DIR}/${FILE}"

     

      #copy template to property file

      cp $templateFile $targetFile

    }

 

    #1 - source template file with path

    #2 - target property file with path

    #3 - keys to be updated with "," separated

    #4 - values to be updated with "," separated

    main "$1" "$2" "$3" "$4"