module coustme.signs;

import std;
import coustme.colorify;
import coustme.WinVer;
import core.sys.windows.windows;
enum {
	WARNING = 0,
	INFO = 1,
	GOOD = 2,
	BAD = 3,
	WHAT = 4
}



string sign(int __sgn){
	WORD Attributes = 0;
	_Version _Ver = new _Version();
	colors color = new colors();
	if(__sgn == 0){
		if(_Ver.GetWinVer() >= Windows_10_11){
			return "["~color.MAG~"!"~color.reset~"] ";
		}else{
			write("[");
			color.SetConsoleColour(&Attributes,color.w_YELLOW);
			write("!");
			color.ResetConsoleColour(Attributes);
			write("]");
			return " ";
		}
	} else if (__sgn == 1) {
		if(_Ver.GetWinVer() >= Windows_10_11){
			return "["~color.MAG~"*"~color.reset~"] ";
		}else{
			write("[");
			color.SetConsoleColour(&Attributes,color.w_MAGENTA);
			write("*");
			color.ResetConsoleColour(Attributes);
			write("]");
			return " ";
		}
	} else if (__sgn == 2) {
		if(_Ver.GetWinVer() >= Windows_10_11){
			return "["~color.GRN~"+"~color.reset~"] ";
		}else{
			write("[");
			color.SetConsoleColour(&Attributes,color.w_GREEN);
			write("+");
			color.ResetConsoleColour(Attributes);
			write("]");
			return " ";
		}
	} else if (__sgn == 3) {
		if(_Ver.GetWinVer() >= Windows_10_11){
			return "["~color.RED~"-"~color.reset~"] ";
		}else{
			write("[");
			color.SetConsoleColour(&Attributes,color.w_RED);
			write("-");
			color.ResetConsoleColour(Attributes);
			write("]");
			return " ";
		}
	} else if (__sgn == 4) {
		if(_Ver.GetWinVer() >= Windows_10_11){
			return "["~color.CYN~"?"~color.reset~"] ";
		}else{
			write("[");
			color.SetConsoleColour(&Attributes,color.w_CYAN);
			write("?");
			color.ResetConsoleColour(Attributes);
			write("]");
			return " ";
		}
	}else{
		return "";
	}


}