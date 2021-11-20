module coustme.Table;

import std;
import Routers._STATUS;
import Routers._HTTP;
import coustme.colorify;
import core.sys.windows.windows;



void print_table(string METHOD, string _STATUS, string PATH, string to = "", string rawdata = ""){
	WORD Attributes = 0;
	STATUS __status = new STATUS();
	colors color = new colors();
	if(_STATUS == __status.OK){
		if (METHOD == GET){
			color.SetConsoleColour(&Attributes,color.w_GREEN);
			writeln(METHOD~"\t"~_STATUS~"\t\t"~PATH);
			color.ResetConsoleColour(Attributes);
		}else{
			color.SetConsoleColour(&Attributes,color.w_GREEN);
			writeln(METHOD~"\t"~_STATUS~"\t\t"~PATH~"\t"~"rawdata"~" "~rawdata);
			color.ResetConsoleColour(Attributes);
		}
	}else if(_STATUS == __status.NOT_FOUND){
		color.SetConsoleColour(&Attributes,color.w_RED);
		writeln(METHOD~"\t"~_STATUS~"\t"~PATH);
		color.ResetConsoleColour(Attributes);
	}else if(_STATUS == __status.FOUND || _STATUS == __status.MOVED_PERMANETLY){
		color.SetConsoleColour(&Attributes,color.w_YELLOW);
		writeln(METHOD~"\t"~_STATUS~"\t"~PATH~"\t"~"redirect -> "~to);
		color.ResetConsoleColour(Attributes);
	}else{
		color.SetConsoleColour(&Attributes,color.w_MAGENTA);
		writeln(METHOD~"\t"~_STATUS~"\t\t"~PATH);
		color.ResetConsoleColour(Attributes);
	}
}