# An impl of the infamous question function
# https://github.com/superwhiskers/question

# TODO Handle questions with [] as valid
# TODO Bug where if you answer an invalid answer and then a valid one, it panics
(defn question [prompt &opt valid] 
	(default valid ["yes" "no"])
	(def joined_valid (string/join valid ", "))

	(file/write stdout (string prompt " " joined_valid ": "))
	(def inp (string/trim (file/read stdin :line)))

	# Janet doesn't have return statements, so this is weird

	(each e valid
		(if (= inp e)
		((print inp " is not a valid answer")
		(question prompt valid))) inp)

# Tests
(print (question "is lithp the betht programming lang?"))

(print "You said: " (question "foo" ["bar" "baz"]))
