MAIN() ;;메인함수



MAIN() ;;메인함수
{
Gui, Show, w200 h127, 알림창	;GUI 생성
waitinglist:= 1
Linenumber:= 0
Loop{ ;; 대기 인원수 구하기
ToolTip,대기인원 연산중
FileReadLine, People, DB\School.txt, %waitinglist%	;DB\School.txt의 S번째줄 내용을 People에 변수할당
IF (People = "한양공업고등학교"){	;변수 People의 문자열이 한양공업고등학교 일경우
waitinglist++	;waitinglist=waitinglist+1
}
ELSE{	;변수 People의 문자열이 한양공업고등학교가 아닐경우
waitinglist:=waitinglist-1 ;waitinglist=waitinglist-1
BREAK ;무한반복 나오기
}
ToolTip
}
loop{ ;;시간
ToolTip,현재시간계산중
Now_time = %A_Hour%:%A_Min%:%A_Sec% ;Now_time변수에 현재시:현재분:현재초 할당
if("08:00:00" > Now_time > "00:00:00"){	;현재시간(Now_time)이 00시00분보다 크고 00시01분 보다 작을때
loop{
Linenumber++	;Linenumber=Linenumber+1
FileReadLine, School, DB\School.txt, %Linenumber% ;DB\School.txt의 Linenumber번째줄 내용을 School에 변수할당
FileReadLine, Name, DB\Name.txt, %Linenumber% ;DB\Name.txt의 Linenumber번째줄 내용을 Name에 변수할당
FileReadLine, Birth, DB\Birth.txt, %Linenumber%	;DB\Birth.txt의 Linenumber번째줄 내용을 Birth에 변수할당
IF (School = "한양공업고등학교"){ ;School의 문자열이 한양공업고등학교 일때
sendkey(School,Name,Birth) ;Sendkey 함수
}
else{
ProgramExit(Linenumber) ;ProgramExit 함수
}
}
}
else{
Guiset(waitinglist) ;Guiset 함수
}
ToolTip
}
return
}



Sendkey(School,Name,Birth) ;Sendkey 함수
{
ToolTip,키보드 입력중
run,http://eduro.sen.go.kr/stv_cvd_co00_002.do	;서울시 학생 자가진단주소 실행
WinWait, 학생 건강상태 자가진단 - Chrome
WinMaximize
sleep,1000	;1초 멈춤
SendInput,%School%	;변수 School 키보드 입력
SendInput,{enter} ;입력
SendInput,{tab}
sleep,1000 ;1초 멈춤
SendInput,%Name%
SendInput,{tab}
sleep,1000 ;1초 멈춤
SendInput,%Birth%
SendInput,{tab}
sleep,1000 ;1초 멈춤
SendInput,{Space}
sleep,2000 ;1초 멈춤
sleep,500 ;1초 멈춤
SendInput,{tab}
sleep,500 ;1초 멈춤
SendInput,{tab}
sleep,500 ;1초 멈춤
SendInput,{Space}
SendInput,{tab}

SendInput,{Space}

SendInput,{tab}

SendInput,{tab}

SendInput,{tab}

SendInput,{tab}

SendInput,{tab}

SendInput,{tab}

SendInput,{tab}

SendInput,{tab}

SendInput,{Space}

SendInput,{tab}

SendInput,{Space}
SendInput,{tab}
SendInput,{Space}
SendInput,{tab}
SendInput,{Space}
sleep,1000 ;1초 멈춤
ToolTip
}




ProgramExit(Linenumber) ;ProgramExit 함수
{
Linenumber--
ToolTip,프로그램 종료중
MsgBox, 0, , 총 %Linenumber%명의 자가진단 완료, 3
Now_time = %A_YYYY%년%A_MM%월%A_DD%일%A_Hour%시%A_Min%분%A_Sec%초 ;Now_time변수에 현재시:현재분:현재초 할당
FileAppend,`n%Now_time% 자가진단을 완료했습니다., ERROR.txt
EXITAPP
ToolTip
}



Guiset(waitinglist) ;Guiset 함수
{
ToolTip,GUI설정중
gui,color,FFFFFF
FormatTime, Nowtime,,H시m분s초
var1=1440
var2:=var1-(A_Hour*60+A_Min)
Gui, Font,S12 ,bold,w700,Verdana
Gui, Add, Text, x2 y9 w280 h30  , %waitinglist%명 대기중
Gui, Add, Text, x2 y39 w280 h30 , 현재 시각 %Nowtime%
Gui, Add, Text, x2 y69 w280 h30 , 프로그램 실행까지
Gui, Add, Text, x2 y99 w280 h30 , % var2//60 "시간" mod(var2,60) "분 남았습니다."
SLEEP,1000
ToolTip
}



F12:: ;hotkey
{
Linenumber--
MsgBox, 0, , 강제종료
msgbox,총 %Linenumber%명의 자가진단 완료
Now_time = %A_YYYY%년%A_MM%월%A_DD%일%A_Hour%시%A_Min%분%A_Sec%초 ;Now_time변수에 현재시:현재분:현재초 할당
FileAppend,`n강제종료 %Now_time% 자가진단을 하던중 오류가 발생했습니다 프로그램을 종료합니다., ERROR.txt
EXITAPP
}
RETURN

GuiClose:
ExitApp
