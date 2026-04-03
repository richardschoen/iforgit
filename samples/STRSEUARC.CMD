/* Name: STRSEUARC                                               */
/* Desc: Start Source Entry Utility with Archive Snapshot        */
/* Type: CMD                                                     */
             CMD        PROMPT('Start Source Entry Utility-Aud')

             PARM       KWD(SRCFILE) TYPE(Q1) +
                          PROMPT('Source file')
 Q1:         QUAL       TYPE(*NAME) LEN(10) DFT(*PRV) SPCVAL((*PRV))
             QUAL       TYPE(*CHAR) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) PROMPT('Library')
             PARM       KWD(SRCMBR) TYPE(*CHAR) LEN(10) DFT(*PRV) +
                          PROMPT('Source member')
             PARM       KWD(TYPE) TYPE(*CHAR) LEN(10) DFT(*SAME) +
                          PROMPT('Source type')
             PARM       KWD(OPTION) TYPE(*CHAR) LEN(6) DFT('5') +
                          PROMPT('Option')
             PARM       KWD(TEXT) TYPE(*CHAR) LEN(30) DFT(*BLANK) +
                          PROMPT('Text description')
