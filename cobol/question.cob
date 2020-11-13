      * TODO: Can this be made more flexible? COBOL lacks some important
      * features like function arguments and variable length arrays
      * which makes it difficult to have a truly conformative
      * implementation, but this gets pretty close.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. question.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-I PIC 99V9 VALUE IS 0.
       01 WS-PROMPT PIC A(03) VALUE "Foo".
       01 WS-V.
               05 WS-ENTRY PIC X(03) OCCURS 2 TIMES INDEXED BY J.
       01 WS-INPUT    PIC A(256).
       01 N   PIC 99 VALUE IS 2.
       01 I   PIC 99 VALUE IS 1.

       01 WS-RESULT PIC A(256).

       PROCEDURE DIVISION.
       MAIN.
           MOVE 'BarBaz' TO WS-V.

           PERFORM QUESTION.
      *> result is found in WS-RESULT
           DISPLAY "You entered: "WS-RESULT.

           STOP RUN.

       QUESTION.
           PERFORM UNTIL WS-I EQUAL 1
               DISPLAY WS-PROMPT
               DISPLAY "("WS-ENTRY(1)", "WS-ENTRY(2)"): " WITH NO
               ADVANCING

               ACCEPT WS-INPUT

               PERFORM UNTIL I > N
                   IF WS-ENTRY(I) EQUAL WS-INPUT THEN
                           MOVE WS-ENTRY(I) TO WS-RESULT
                           SET WS-I TO 1
                   END-IF

                   ADD 1 TO I
               END-PERFORM

               SET I TO 0
           END-PERFORM.
