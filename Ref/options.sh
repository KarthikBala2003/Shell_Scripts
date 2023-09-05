while getopts n:c: opt
do
    case "${opt}" in
          n) name=${OPTARG};;
          c) country=${OPTARG}
     esac
done
echo "I am $name";
echo  "And I live in $country";

#bash options.sh -n Karthik  -c India