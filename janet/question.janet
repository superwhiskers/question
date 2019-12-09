<<<<<<< HEAD
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
=======
(defn in-array [a i e]
  "check if e is in a. return nil if not, returns e if it is"
  (cond
    (= (length a) i) nil
    (= (get a i) e) e
    (in-array a (inc i) e)))

(defn question [prompt valid]
  "implementation of the question function in janet"
  (let [joined-valid (string/join valid ", ")]
    (print prompt)
    (if (> (length valid) 0)
      (prin (string/format "(%s)" joined-valid)))
    (prin ": ")
    (let [inp (string/trim (file/read stdin :line))]
      (if (= (length valid) 0)
        inp)
      (let [validation-result (in-array valid 0 inp)]
        (if (= validation-result nil)
          (do (printf "\"%s\" is not a valid answer" inp)
            (question prompt valid))
          validation-result)))))

(question "foo" ["bar" "baz"])
>>>>>>> 070f7dcc537fe75cd2ab5c0a4d42853db3bdce46
