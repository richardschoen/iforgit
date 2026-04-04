/* Name: STRSEUARC                                               */
/* Desc: Start Source Entry Utility with Git Commit After        */
/* Type: CMD                                                     */
             CMD        PROMPT('Start SEU and Commit Changes')

             PARM       KWD(SRCFILE) TYPE(Q1) +
                          PROMPT('Source file')
 Q1:         QUAL       TYPE(*NAME) LEN(10) DFT(*PRV) SPCVAL((*PRV))
             QUAL       TYPE(*CHAR) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) PROMPT('Library')
             PARM       KWD(SRCMBR) TYPE(*CHAR) LEN(10) DFT(*PRV) +
                          PROMPT('Source member')
             PARM       KWD(TYPE) TYPE(*CHAR) LEN(10) DFT(*SAME) +
                          PROMPT('Source type')
             PARM       KWD(OPTION) TYPE(*CHAR) LEN(6) DFT(*BLANK) +
                          SPCVAL((*BLANK ' ')) PROMPT('Option')
             PARM       KWD(TEXT) TYPE(*CHAR) LEN(30) DFT(*BLANK) +
                          PROMPT('Text description')
             PARM       KWD(PMTCOMMENT) TYPE(*CHAR) LEN(4) +
                          RSTD(*YES) DFT(*YES) VALUES(*NO *YES) +
                          PROMPT('Prompt user for Git comment')
