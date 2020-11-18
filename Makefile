Readme: guessinggame.sh
	touch README.md
	echo "# Coursera_BASH_project" > README.md
	echo "The number of lines in the guessinggame script is:" >> README.md
	wc -l guessinggame.sh | egrep -o "[0-9][0-9]" >> README.md
	echo $$(date) >> README.md
	echo "  \n" >> README.md