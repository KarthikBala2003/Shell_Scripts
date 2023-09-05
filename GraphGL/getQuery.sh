GRAPHQL_TOKEN=Mr1RsZzksRWt5QyexQty
# current_user=$(curl -s -H "Authorization: Bearer $GRAPHQL_TOKEN" \
	# -H "Content-Type: application/json" \
	# -X POST -d "@GraphQL_GitLab_QueryData.json" 'https://gitlab.com/api/graphql' | grep name | cut -d":" -f4 | tr -d ',",}') 

# curl -L --header "PRIVATE-TOKEN: $GRAPHQL_TOKEN" "https://gitlab.com/karthikbala2003/api/v4/projects/1/triggers/5" -o response.html
# echo "Current User: ${current_user}"
