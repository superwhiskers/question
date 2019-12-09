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
