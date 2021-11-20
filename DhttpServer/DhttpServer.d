module DhttpServer;

import std;
import core.thread;
import core.sys.windows.windows;
import Routers._HTTP;
import coustme.signs;
import coustme.Table;



    
int main()
{
     
    //write();
    //pause();
    show_console_cursor(false);
    SetConsoleTitleW("DhttpServer | instagram @0xdevil - status: Server: offline , port: n/a , ip: n/a");
	enum ushort PORT = 8080;
	const char[] _hostname = "localhost"/+ localhost +/;
    int requests_count = 0;
    SetConsoleTitleW(to!(wchar[])(format("DhttpServer | instagram @0xdevil - status: Server=offline , wait for listen on port=%d ~ host=%s;",PORT,_hostname)).ptr);
    writeln(sign(INFO) ~ "initialization the Server !");
    writeln(sign(INFO) ~ "Server: PORT="~to!string(PORT));
    writeln(sign(INFO) ~ "Server: HOST_NAME="~_hostname);
    Thread.sleep( 2.seconds );
    _Server server = new _Server(_hostname, PORT);
    if(server.__init__server()){
		SetConsoleTitleW(to!(wchar[])(format("DhttpServer | instagram @0xdevil - status: Server=Online , listen on port=%d ~ host=%s;",PORT,_hostname)).ptr);
        writeln(sign(GOOD) ~ "Server: Online");
        if (PORT == to!ushort(80) || PORT == to!ushort(443)){
              writeln(sign(INFO) ~ "Server: listen on http://"~_hostname);
		}else{
			 writeln(sign(INFO) ~ "Server: listen on http://"~_hostname~":"~to!string(PORT));
		}
        SetConsoleTitleW(to!(wchar[])(format("DhttpServer | instagram @0xdevil - status: Server=Online , listen on port=%d ~ host=%s; requests=%d",PORT,_hostname, requests_count)).ptr);
        writeln("\n\nHTTP Requests\n--------------------------------------------------------");
        do{
			try{
                server.startServer();
                requests_count++;
                print_table(server.last_method,server.last_status, server.last_path,server.last_redirect,server.last_rawdata);
                SetConsoleTitleW(to!(wchar[])(format("DhttpServer | instagram @0xdevil - status: Server=Online , listen on port=%d ~ host=%s; requests=%d",PORT,_hostname, requests_count)).ptr);
			}catch(Exception ex){
                /+ pass +/
			}
            
        }while(true);
	}else{
		SetConsoleTitleW(to!(wchar[])(format("DhttpServer | instagram @0xdevil - status: Server=Error;")).ptr);
        writeln(sign(BAD)~"initialization was bad .");
            
	}
    pause();

    return 0;
}


void show_console_cursor(const bool show) {

    HANDLE handle = GetStdHandle(STD_OUTPUT_HANDLE);
    CONSOLE_CURSOR_INFO cci;
    GetConsoleCursorInfo(handle, &cci);
    cci.bVisible = show;
    SetConsoleCursorInfo(handle, &cci);
}
void pause(){
    executeShell("pause > null");
}