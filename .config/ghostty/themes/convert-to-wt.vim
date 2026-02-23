%s/^background =/"background": /g
%s/^foreground =/"foreground": /g
%s/selection-background =/"selectionBackground": /g
%s/cursor-color =/"cursorColor": /g
%s/palette = 0=/"black": /g
%s/palette = 8=/"brightBlack": /g
%s/palette = 1=/"red": /g
%s/palette = 9=/"brightRed": /g
%s/palette = 2=/"green": /g
%s/palette = 10=/"brightGreen": /g
%s/palette = 3=/"yellow": /g
%s/palette = 11=/"brightYellow": /g
%s/palette = 4=/"blue": /g
%s/palette = 12=/"brightBlue": /g
%s/palette = 5=/"purple": /g
%s/palette = 13=/"brightPurple": /g
%s/palette = 6=/"cyan": /g
%s/palette = 14=/"brightCyan": /g
%s/palette = 7=/"white": /g
%s/palette = 15=/"brightWhite": /g
%s/#[0-9A-Fa-f]\{6}$/"\U\0",/g
%s/^selection-foreground.*//g
%s/^#.*//g
%s/^\n//g
sort
