
#pragma hdrstop
#include <condefs.h>


//---------------------------------------------------------------------------
USEUNIT("..\src\lclib.c");
USEUNIT("..\src\littlec.c");
USEUNIT("..\src\parser.c");
//---------------------------------------------------------------------------
#pragma argsused
// This is a hack to trick the IDE into thinking
// that this is the primary unit file
#if __BORLANDC__
#else
int main(int argc, char **argv)
{
    return 0;
}
#endif