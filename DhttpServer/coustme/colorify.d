module coustme.colorify;

import core.sys.windows.windows;
import coustme.WinVer;
class colors{

	HANDLE __stdouthandle;
	_Version _Ver = new _Version();

	enum string BLK  =  "\x1b[0;30m";
	enum string RED  =  "\x1b[0;31m";
	enum string GRN  =  "\x1b[0;32m";
	enum string YEL  =  "\x1b[0;33m";
	enum string BLU  =  "\x1b[0;34m";
	enum string MAG  =  "\x1b[0;35m";
	enum string CYN  =  "\x1b[0;36m";
	enum string WHT  =  "\x1b[0;37m";
	enum string reset = "\x1b[0m";

	enum WORD w_BLACK	    = 0;
	enum WORD w_BLUE	        = 1;
	enum WORD w_GREEN	    = 2;
	enum WORD w_CYAN	        = 3;
	enum WORD w_RED	        = 4;
	enum WORD w_MAGENTA	    = 5;
	enum WORD w_BROWN	    = 6;
	enum WORD w_LIGHTGRAY	= 7;
	enum WORD w_DARKGRAY	    = 8;
	enum WORD w_LIGHTBLUE	= 9;
	enum WORD w_LIGHTGREEN	= 10;
	enum WORD w_LIGHTCYAN    = 11;
	enum WORD w_LIGHTRED	    = 12;
	enum WORD w_LIGHTMAGENTA = 13;
	enum WORD w_YELLOW	    = 14;
	enum WORD w_WHITE	    = 15;

	this(){
		if(_Ver.GetWinVer() >= Windows_10_11){
			__stdouthandle = GetStdHandle(STD_OUTPUT_HANDLE);
			DWORD dwrd;
			GetConsoleMode(__stdouthandle, &dwrd);          
			dwrd |= ENABLE_VIRTUAL_TERMINAL_PROCESSING; /+ Only for windows 10 or higher +/
			SetConsoleMode(__stdouthandle, dwrd);
		}else{
			__stdouthandle = GetStdHandle(STD_OUTPUT_HANDLE);
		}
	}


	/+ Windows 7 or lower methods +/
	void SetConsoleColour(WORD* Attributes, ushort Colour)
	{
		CONSOLE_SCREEN_BUFFER_INFO Info;
		HANDLE hStdout = GetStdHandle(STD_OUTPUT_HANDLE);
		GetConsoleScreenBufferInfo(hStdout, &Info);
		*Attributes = Info.wAttributes;
		SetConsoleTextAttribute(hStdout, Colour);
	}

	void ResetConsoleColour(WORD Attributes)
	{
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), Attributes);
	}

}