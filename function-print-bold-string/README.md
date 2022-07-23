A function that gets a string and prints it in bold format.
usage:
```
bold "$1"
```
--- 

    bold=$(tput bold)
    italic=$(tput sitm) 
    reset=$(tput sgr0)


tput  options:
Capname	Description
```
bold	Start bold text
stim  start italic text
smul	Start underlined text
rmul	End underlined text
blink	Start blinking text
invis	Start invisible text
sgr0	Turn off all attributes
setaf <value>	Set foreground color
setab <value>	Set background color
```
  ---
  
 Value	Color
```
0	Black
1	Red
2	Green
3	Yellow
4	Blue
5	Magenta
6	Cyan
7	White
8	Not used
9	Reset to default color
```
