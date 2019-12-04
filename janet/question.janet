# An impl of the infamous question function
# https://github.com/superwhiskers/question

# Func to check if an element is in a list
(defn in-list [e list]
	(var res false)
	(each i list (if (= i e) (set res true)))
	res)

# TODO Handle questions with [] as valid
# TODO Bug where if you answer an invalid answer and then a valid one, it panics
(defn question [prompt &opt valid] 
	(default valid ["yes" "no"])
	(def joined_valid (string/join valid ", "))

	(file/write stdout (string prompt " " joined_valid ": "))
	(def inp (string/trim (file/read stdin :line)))

	# Janet doesn't have return statements, so this is weird

	(if (not (in-list inp valid))
		((print "Please enter a valid answer")
		(question prompt valid))) inp)

# Tests
(def ans (question "is lithp the betht programming lang?"))
(if (= ans "no") (print "Wrong answer"))

(print)

(print "You said: " (question "foo" ["bar" "baz"]))
