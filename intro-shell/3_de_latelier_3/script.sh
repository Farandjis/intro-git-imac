x=$(head -n1 input.txt)
ligne2=$(sed -n '2p' input.txt)

declare -A occurences

for ((i=0; i<x*2; i++)); do
    char="${ligne2:i:1}"
    #echo "Caractère $((i+1)) : $char"
    [[ -z "$char" ]] && break

    if [[ -v occurences["$char"] ]]; then
        occurences["$char"]=$(( occurences["$char"] + 1 ))
    else
        occurences["$char"]=1
    fi
done


for key in "${!occurences[@]}"; do
    # echo "Clé : '$key' → Valeur : ${occurences[$key]}"

    if [[ "${occurences[$key]}" -eq 1 && "$key" != " " ]]; then
       echo "La vakeur '$key' a une seule occurrence."
    fi

done
