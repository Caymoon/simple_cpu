# simple_cpu
计算机设计与实践课程项目，设计一个简易处理器<br/>
可完成以下指令：<br/>
ADD Ri,Rj			Ri<-Ri+Rj<br/>
SUB Ri,Rj			Ri<-Ri-Rj<br/>
MOV Ri,Rj			Ri<-Rj<br/>
MVI Ri,X			Ri<-X<br/>
LDA Ri,X			Ri<-[R7//X]<br/>
STA Ri,X			[R7//X]<-Ri<br/>
JMP X				PC<-R7//X<br/>
JZ Ri,X				IF(Ri = 0) then PC<-R7//X<br/>
IN Ri,PORT			Ri<-PORT<br/>
OUT Ri,PORT			PORT<-Ri<br/>
