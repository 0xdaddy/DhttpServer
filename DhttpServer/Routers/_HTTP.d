module Routers._HTTP;


import std;
import Routers.reference.GETTER;
import Routers._STATUS;
extern (C) int strcmp(const char* string1, const char* string2);

enum string GET = "GET";
enum string POST = "POST";

class _Server{
	
	struct _PATH{
		string INDEX = "/";
		string LOGIN = "/login";
	}

	struct _request{
		string METHOD;
		string PATH;
		string rawData;
	}
	
	struct _response{
		string STATUS;
		string PATH;
	}

	STATUS _status = new STATUS();
	templates _template = new templates();
	TcpSocket listener ;
	Socket client;

	_request __request;
	_PATH __PATH;
	_response __response;

	
	string main_dir = "templates";
	string last_rawdata = "";
	string last_redirect = "";
	string s_request;
	string last_status;
	string last_method;
	string last_path;
	string[] requestArr_space ;
	string[] requestArr_new_line ;

	
	ushort PORT ;
    const char[] _hostname ;
	char[1024] c_request;

	this(const char[] _Ip, ushort PORT){
		this._hostname = _Ip;
		this.PORT = PORT;
	}


	bool __init__server(){
		try{
			const char[] __Ip = to!(char[])(get_ip(to!string(_hostname)));
			
			listener = new TcpSocket();
			listener.blocking = true; 
			listener.bind(new InternetAddress(__Ip , PORT));
			listener.listen(1);
			return true;
		}catch(Exception ex){
			return false;
		}
		
	}
	
	string get_ip(string hostname){
		string Ip;
		try
		{
			auto addresses = getAddress(hostname);
			foreach (address; addresses)
				Ip = address.toAddrString();
		}
		catch (SocketException e){	
			//throw("Lookup failed: %s", e.msg);
		}
		return Ip;
	}

	void startServer(){
		
		client = listener.accept();
		int bufflen = client.receive(c_request);
        if (bufflen == Socket.ERROR){

		}else{
			
			s_request = to!string(c_request[0..bufflen]);
			requestArr_space = s_request.split(" ");
			requestArr_new_line = s_request.split("\n");
			__request.METHOD  = requestArr_space[0];
			__request.PATH	 = requestArr_space[1];
			if(!strcmp(to!(char[])(__request.METHOD).ptr , to!(char[])(GET).ptr)){
				if(!strcmp(to!(char[])(__request.PATH).ptr, to!(char[])(__PATH.INDEX).ptr)){
					__response.PATH = main_dir~"/index.html";
					__response.STATUS = _status.OK;
					client.send((format( "%s\n\n%s",__response.STATUS ,_template.PAGE(__response.PATH))));
					client.close();
				}else if(!strcmp(to!(char[])(__request.PATH).ptr, to!(char[])(__PATH.LOGIN).ptr)){
					__response.PATH = main_dir~"/login.html";
					__response.STATUS = _status.OK;
					client.send((format( "%s\n\n%s",__response.STATUS,_template.PAGE(__response.PATH))));
					client.close();
				}else if(!__request.PATH.find("/login.html").empty){
					__response.STATUS = _status.FOUND;
					this.last_redirect = "http://localhost:8080/login";
					client.send((format( "%s\nLocation: %s\n\n302",__response.STATUS,this.last_redirect)));
					client.close();
				}else if(exists(main_dir~__request.PATH)){
						__response.PATH = main_dir~__request.PATH;
						__response.STATUS = _status.OK;
						client.send((format( "%s\n\n%s",__response.STATUS ,_template.PAGE(__response.PATH ))));
						client.close();
						
				}else{
						__response.PATH = main_dir~"/Err/404.html";
						__response.STATUS = _status.NOT_FOUND;
						client.send((format( "%s\n\n%s",__response.STATUS,_template.PAGE(__response.PATH))));
						client.close();
					}
			this.last_method = __request.METHOD;
			this.last_path = __request.PATH;
			this.last_status = __response.STATUS;
			}else if(!strcmp(to!(char[])(__request.METHOD).ptr , to!(char[])(POST).ptr)){
				s_request = to!string(c_request[0..bufflen]);
				requestArr_space = s_request.split(" ");
				requestArr_new_line = s_request.split("\n");
				__request.METHOD  = requestArr_space[0];
				__request.PATH	 = requestArr_space[1];
				if (__request.PATH == "/login"){
					__request.rawData = requestArr_new_line[$ - 1];
					string[] __data_s = __request.rawData.split("&");	
					string last_key;
					JSONValue J;
					foreach(string __data ; __data_s){
						string[] __items = __data.split("=");	
						foreach(string  key ; __items){
							J[key] = "";
							last_key = key;
							break;
						}
						foreach(i, string value; __items){
							if (i == 1 ){
								J[last_key] = value;
								break;
							}
						}
					}
					__response.PATH = main_dir~"/login.html";
					
					if(J["username"].str == "admin" && J["password"].str == "admin"){
						__response.STATUS = _status.OK;
						client.send((format( "%s\n\n%s",__response.STATUS,_template.PAGE(__response.PATH)~"\n<p>Welcome admin</p>")));
						client.close();
					}else{
						__response.STATUS = _status.FORBIDDEN;
						client.send((format( "%s\n\n%s",__response.STATUS,_template.PAGE(__response.PATH)~"\n<p>Who are you!</p>")));
						client.close();
					}
				}
			}
			this.last_rawdata = __request.rawData;
			this.last_method = __request.METHOD;
			this.last_path = __request.PATH;
			this.last_status = __response.STATUS;
		}
	}
}