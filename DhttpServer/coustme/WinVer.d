module coustme.WinVer;
import core.sys.windows.windows;


enum {
	int Windows_10_11 = 602931718,
	int Windows_7 = 498139398,
	int Windows_XP = 170393861 
}

class _Version{

	DWORD GetWinVer() {
		DWORD _version = GetVersion();
		DWORD major = cast	(DWORD)(LOBYTE(LOWORD(_version)));
		DWORD minor = cast	(DWORD)(HIBYTE(LOWORD(_version)));
		return _version;
	}
}