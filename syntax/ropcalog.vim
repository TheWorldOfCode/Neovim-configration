syntax region ropcaLogConceal start="@" end="::" conceal cchar=: contained
syntax region ropcaLogDebug start="\d\+_\d\+_\d\+_\d\+@DEBUG" end="$" contains=ropcaLogConceal
syntax region ropcaLogInfo start="\d\+_\d\+_\d\+_\d\+@INFO" end="$" contains=ropcaLogConceal
syntax region ropcaLogWarning start="\d\+_\d\+_\d\+_\d\+@WARNING" end="$" contains=ropcaLogConceal
syntax region ropcaLogError start="\d\+_\d\+_\d\+_\d\+@ERROR" end="$" contains=ropcaLogConceal
syntax region ropcaLogFatal start="\d\+_\d\+_\d\+_\d\+@FATAL" end="$" contains=ropcaLogConceal



highlight link ropcaLogDebug GreenSign
highlight link ropcaLogInfo text
highlight link ropcaLogWarning YellowSign
highlight link ropcaLogError  RedSign
highlight link ropcaLogFatal TSDanger
