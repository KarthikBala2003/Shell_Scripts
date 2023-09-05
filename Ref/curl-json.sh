curl -s https://jsonplaceholder.typicode.com/todos/1 | grep -Po '"title"\s*:\s*"\K([^"]*)'
curl -s https://jsonplaceholder.typicode.com/todos/1 | grep -Po '"userId"\s*:\s*[0-9]'