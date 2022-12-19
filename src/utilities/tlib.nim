##[
 `TLIB`, my custom terminal library
]##

import strformat, os, strutils

proc rgb*(r:Natural, g:Natural, b:Natural): string=
    ## Return RGB escape sequance
    result = &"\e[38;2;{r};{g};{b}m"

proc rgbBg*(r:Natural, g:Natural, b:Natural): string=
    ## Return RGB escape sequance (Background)
    result = &"\e[48;2;{r};{g};{b}m"

proc moveCursorUp*(n: int)=
    ## Move the cursor up n lines
    stdout.write(&"\e[{n}A")

proc moveCursorDown*(n: int)=
    ## Move the cursor down n lines
    stdout.write(&"\e[{n}B")

proc moveCursorRight*(n: int)=
    ## Move the cursor left n chars
    stdout.write(&"\e[{n}C")

proc moveCursorLeft*(n: int)=
    ## Move the cursor right n chars
    stdout.write(&"\e[{n}D")

proc saveCursorPos*()=
    ## Save the current cursor position, can be restored later
    stdout.write("\e[s")

proc restorCursorPos*()=
    ## Restor previously saved cursor position
    stdout.write("\e[u")

proc read*(args: string): string =
    ## Same as INPUT in python
    stdout.write(args)
    result = stdin.readline()

proc def*():string =
    ## Return default color code
    result = "\e[0m"

proc italic*():string =
    ## Return Italic code
    result = "\e[3m"

proc bold*():string =
    result = "\e[21m"

proc clear*()=
    ## Clear the screen using system commands
    var cmd: string
    when defined(windows):
        cmd = "cls"
    else:
        cmd = "clear"
    
    discard os.execShellCmd(cmd)

proc rmline*() =
    stdout.writeLine("\e[2K")

when not defined(windows):
    import termios

    type
        Key* {.pure.} = enum      ## Supported single key presses and key combinations
            None = (0, "None"),

            # Special ASCII characters
            CtrlA  = (1, "CtrlA"),
            CtrlB  = (2, "CtrlB"),
            CtrlC  = (3, "CtrlC"),
            CtrlD  = (4, "CtrlD"),
            CtrlE  = (5, "CtrlE"),
            CtrlF  = (6, "CtrlF"),
            CtrlG  = (7, "CtrlG"),
            CtrlH  = (8, "CtrlH"),
            Tab    = (9, "\t"),     # Ctrl-I
            CtrlJ  = (10, "CtrlJ"),
            CtrlK  = (11, "CtrlK"),
            CtrlL  = (12, "CtrlL"),
            Enter  = (13, "Enter"),  # Ctrl-M
            CtrlN  = (14, "CtrlN"),
            CtrlO  = (15, "CtrlO"),
            CtrlP  = (16, "CtrlP"),
            CtrlQ  = (17, "CtrlQ"),
            CtrlR  = (18, "CtrlR"),
            CtrlS  = (19, "CtrlS"),
            CtrlT  = (20, "CtrlT"),
            CtrlU  = (21, "CtrlU"),
            CtrlV  = (22, "CtrlV"),
            CtrlW  = (23, "CtrlW"),
            CtrlX  = (24, "CtrlX"),
            CtrlY  = (25, "CtrlY"),
            CtrlZ  = (26, "CtrlZ"),
            Escape = (27, "Escape"),

            CtrlBackslash    = (28, "CtrlBackslash"),
            CtrlRightBracket = (29, "CtrlRightBracket"),

            # Printable ASCII characters
            Space           = (32, " "),
            ExclamationMark = (33, "!"),
            DoubleQuote     = (34, "\""),
            Hash            = (35, "#"),
            Dollar          = (36, "$"),
            Percent         = (37, "%"),
            Ampersand       = (38, "&"),
            SingleQuote     = (39, "'"),
            LeftParen       = (40, "("),
            RightParen      = (41, ")"),
            Asterisk        = (42, "*"),
            Plus            = (43, "+"),
            Comma           = (44, ","),
            Minus           = (45, "-"),
            Dot             = (46, "."),
            Slash           = (47, "/"),

            Zero  = (48, "0"),
            One   = (49, "1"),
            Two   = (50, "2"),
            Three = (51, "3"),
            Four  = (52, "4"),
            Five  = (53, "5"),
            Six   = (54, "6"),
            Seven = (55, "7"),
            Eight = (56, "8"),
            Nine  = (57, "9"),

            Colon        = (58, ":"),
            Semicolon    = (59, ";"),
            LessThan     = (60, "<"),
            Equals       = (61, "="),
            GreaterThan  = (62, ">"),
            QuestionMark = (63, "?"),
            At           = (64, "@")

            ShiftA  = (65, "A"),
            ShiftB  = (66, "B"),
            ShiftC  = (67, "C"),
            ShiftD  = (68, "D"),
            ShiftE  = (69, "E"),
            ShiftF  = (70, "F"),
            ShiftG  = (71, "G"),
            ShiftH  = (72, "H"),
            ShiftI  = (73, "I"),
            ShiftJ  = (74, "J"),
            ShiftK  = (75, "K"),
            ShiftL  = (76, "L"),
            ShiftM  = (77, "M"),
            ShiftN  = (78, "N"),
            ShiftO  = (79, "O"),
            ShiftP  = (80, "P"),
            ShiftQ  = (81, "Q"),
            ShiftR  = (82, "R"),
            ShiftS  = (83, "S"),
            ShiftT  = (84, "T"),
            ShiftU  = (85, "U"),
            ShiftV  = (86, "V"),
            ShiftW  = (87, "W"),
            ShiftX  = (88, "X"),
            ShiftY  = (89, "Y"),
            ShiftZ  = (90, "Z"),

            LeftBracket  = (91, "["),
            Backslash    = (92, r"\"),
            RightBracket = (93, "]"),
            Caret        = (94, "^"),
            Underscore   = (95, "_"),
            GraveAccent  = (96, "`"),

            A = (97, "a"),
            B = (98, "b"),
            C = (99, "c"),
            D = (100, "d"),
            E = (101, "e"),
            F = (102, "f"),
            G = (103, "g"),
            H = (104, "h"),
            I = (105, "i"),
            J = (106, "j"),
            K = (107, "k"),
            L = (108, "l"),
            M = (109, "m"),
            N = (110, "n"),
            O = (111, "o"),
            P = (112, "p"),
            Q = (113, "q"),
            R = (114, "r"),
            S = (115, "s"),
            T = (116, "t"),
            U = (117, "u"),
            V = (118, "v"),
            W = (119, "w"),
            X = (120, "x"),
            Y = (121, "y"),
            Z = (122, "z"),

            LeftBrace  = (123, "{"),
            Pipe       = (124, "|"),
            RightBrace = (125, "}"),
            Tilde      = (126, "~"),
            Backspace  = (127, "\x7f"),

            # Special characters with virtual keycodes
            
            F1  = (277980, "F1"),
            F2  = (277981, "F2"),
            F3  = (277982, "F3"),
            F4  = (277983, "F4"),
            
            Delete   = (279151, "Delete"),
            PageUp   = (279153, "PageUp"),
            PageDown = (279154, "PageDown"),
            Up       = (279165, "Up"),
            Down     = (279166, "Down"),
            Right    = (279167, "Right"),
            Left     = (279168, "Left"),
            End      = (279170, "End"),

            ShiftTab = (279190, "ShiftTab"),

            F9  = (27914948126, "F9"),
            F10 = (27914949126, "F10"),
            F11 = (27914951059, "F11"),
            F12 = (27914952126, "F12")

            F5  = (27914953126, "F5"),
            F6  = (27914955126, "F6"),
            F7  = (27914956126, "F7"),
            F8  = (27914957126, "F8")
    
        

    proc setRaw(fd: FileHandle, time: cint = TCSAFLUSH) =
        ## Sets the terminal fd to raw mod according to termios(3)
        var mode: Termios
        discard fd.tcGetAttr(addr mode)
        mode.c_iflag = mode.c_iflag and not Cflag(IGNBRK or BRKINT or PARMRK or ISTRIP or INLCR or IGNCR or ICRNL or IXON)
        mode.c_oflag = not OPOST
        mode.c_cflag = (mode.c_cflag and not Cflag(CSIZE or PARENB)) or CS8
        mode.c_lflag = mode.c_lflag and not Cflag(ECHO or ECHONL or ICANON or ISIG or IEXTEN)
        discard fd.tcSetAttr(time, addr mode)

    proc getChar():uint =
        # aquire stdin handle
        let fd = getFileHandle(stdin)
        var oldMode: Termios
        # save our stdin state
        discard fd.tcGetAttr(addr oldMode)
        # set our stdin to raw mode
        fd.setRaw()
        var 
            buf: array[1, uint8]
            buf2: array[2, uint8]
        
        # Read one byte and put it in buf
        discard stdin.readBytes(buf, 0, 1)
        # check if the char is the escape one '^', if so read 2 more bytes into buf 2 and return it
        if buf[0] == 27.uint8:
            discard stdin.readBytes(buf2, 0, 2)
            # check if the sequence starts with [[ or [[ (different brackets)
            if buf2 == [uint8(91), uint8(49)] or buf2 == [uint8(91), uint8(50)]: 
                # read the next two bytes
                discard stdin.readBytes(buf2, 0, 2)
                discard fd.tcSetAttr(TCSAFLUSH, addr oldMode)
                return ((279149*100 + buf2[0])*1000 + buf2[1])
                

            discard fd.tcSetAttr(TCSADRAIN, addr oldMode)
            return (2700 + buf2[0]) * 100 + buf2[1]
        # put the first byte in our result variable
        result = buf[0]
        # Reset our stdin with the saved state from oldMode
        discard fd.tcSetAttr(TCSADRAIN, addr oldMode)


    proc getKey*():Key =
        {.warning[HoleEnumConv]:off.}
        try:
            return Key(getChar())
        except:
            stdout.write "Unsupported key"
            return
            

proc hidecursor*() =
  when defined(windows):
    discard
  else:
    stdout.writeLine("\e[?25l")

type EKeyboardInterrupt* = object of CatchableError
proc handler() {.noconv.} =
  raise newException(EKeyboardInterrupt, "Keyboard Interrupt")
setControlCHook(handler)

proc showcursor*() =
  when defined(windows):
    discard
  else:
    stdout.writeLine("\e[?25h")

when isMainModule:
    echo "This can't be used by itself"
    quit(1)

when (not isMainModule) and defined(windows):
    import osproc
    let regi = execCmdEx("reg query HKCU\Console /v VirtualTerminalLevel")[0]
    if not ("0x1" in regi):
        discard os.execShellCmd("reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 00000001")
