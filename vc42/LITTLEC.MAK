# Microsoft Developer Studio Generated NMAKE File, Format Version 4.20
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

!IF "$(CFG)" == ""
CFG=LITTLEC - Win32 Debug
!MESSAGE No configuration specified.  Defaulting to LITTLEC - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "LITTLEC - Win32 Release" && "$(CFG)" !=\
 "LITTLEC - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE on this makefile
!MESSAGE by defining the macro CFG on the command line.  For example:
!MESSAGE 
!MESSAGE NMAKE /f "LITTLEC.MAK" CFG="LITTLEC - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "LITTLEC - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "LITTLEC - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 
################################################################################
# Begin Project
# PROP Target_Last_Scanned "LITTLEC - Win32 Debug"
RSC=rc.exe
CPP=cl.exe

!IF  "$(CFG)" == "LITTLEC - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
OUTDIR=.\Release
INTDIR=.\Release

ALL : "$(OUTDIR)\LITTLEC.exe" "$(OUTDIR)\LITTLEC.bsc"

CLEAN : 
	-@erase "$(INTDIR)\lclib.obj"
	-@erase "$(INTDIR)\lclib.sbr"
	-@erase "$(INTDIR)\littlec.obj"
	-@erase "$(INTDIR)\littlec.sbr"
	-@erase "$(INTDIR)\parser.obj"
	-@erase "$(INTDIR)\parser.sbr"
	-@erase "$(OUTDIR)\LITTLEC.bsc"
	-@erase "$(OUTDIR)\LITTLEC.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

# ADD BASE CPP /nologo /W3 /GX- /Ox /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_DOS" /FR /YX /c
# ADD CPP /nologo /W3 /GX- /Ox /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_DOS" /FR /YX /c
CPP_PROJ=/nologo /ML /W3 /GX- /Ox /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D\
 "_DOS" /FR"$(INTDIR)/" /Fp"$(INTDIR)/LITTLEC.pch" /YX /Fo"$(INTDIR)/" /c 
CPP_OBJS=.\Release/
CPP_SBRS=.\Release/
# ADD BASE RSC /l 0x1409 /d "NDEBUG"
# ADD RSC /l 0x1409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/LITTLEC.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\lclib.sbr" \
	"$(INTDIR)\littlec.sbr" \
	"$(INTDIR)\parser.sbr"

"$(OUTDIR)\LITTLEC.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
# ADD BASE LINK32 oldnames.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /stack:0x1400 /subsystem:console /machine:IX86
# ADD LINK32 oldnames.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /stack:0x1400 /subsystem:console /machine:IX86
LINK32_FLAGS=oldnames.lib kernel32.lib user32.lib gdi32.lib winspool.lib\
 comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib\
 odbc32.lib odbccp32.lib /nologo /stack:0x1400 /subsystem:console\
 /incremental:no /pdb:"$(OUTDIR)/LITTLEC.pdb" /machine:IX86\
 /out:"$(OUTDIR)/LITTLEC.exe" 
LINK32_OBJS= \
	"$(INTDIR)\lclib.obj" \
	"$(INTDIR)\littlec.obj" \
	"$(INTDIR)\parser.obj"

"$(OUTDIR)\LITTLEC.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "LITTLEC - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
OUTDIR=.\Debug
INTDIR=.\Debug

ALL : "$(OUTDIR)\LITTLEC.exe" "$(OUTDIR)\LITTLEC.bsc"

CLEAN : 
	-@erase "$(INTDIR)\lclib.obj"
	-@erase "$(INTDIR)\lclib.sbr"
	-@erase "$(INTDIR)\littlec.obj"
	-@erase "$(INTDIR)\littlec.sbr"
	-@erase "$(INTDIR)\parser.obj"
	-@erase "$(INTDIR)\parser.sbr"
	-@erase "$(INTDIR)\vc40.idb"
	-@erase "$(INTDIR)\vc40.pdb"
	-@erase "$(OUTDIR)\LITTLEC.bsc"
	-@erase "$(OUTDIR)\LITTLEC.exe"
	-@erase "$(OUTDIR)\LITTLEC.ilk"
	-@erase "$(OUTDIR)\LITTLEC.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

# ADD BASE CPP /nologo /W3 /Gm /GX- /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_DOS" /FR /YX /c
# ADD CPP /nologo /W3 /Gm /GX- /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_DOS" /FR /YX /c
CPP_PROJ=/nologo /MLd /W3 /Gm /GX- /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "_DOS" /FR"$(INTDIR)/" /Fp"$(INTDIR)/LITTLEC.pch" /YX /Fo"$(INTDIR)/"\
 /Fd"$(INTDIR)/" /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.\Debug/
# ADD BASE RSC /l 0x1409 /d "_DEBUG"
# ADD RSC /l 0x1409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/LITTLEC.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\lclib.sbr" \
	"$(INTDIR)\littlec.sbr" \
	"$(INTDIR)\parser.sbr"

"$(OUTDIR)\LITTLEC.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
# ADD BASE LINK32 oldnames.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /stack:0x1400 /subsystem:console /debug /machine:IX86
# ADD LINK32 oldnames.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /stack:0x1400 /subsystem:console /debug /machine:IX86
LINK32_FLAGS=oldnames.lib kernel32.lib user32.lib gdi32.lib winspool.lib\
 comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib\
 odbc32.lib odbccp32.lib /nologo /stack:0x1400 /subsystem:console\
 /incremental:yes /pdb:"$(OUTDIR)/LITTLEC.pdb" /debug /machine:IX86\
 /out:"$(OUTDIR)/LITTLEC.exe" 
LINK32_OBJS= \
	"$(INTDIR)\lclib.obj" \
	"$(INTDIR)\littlec.obj" \
	"$(INTDIR)\parser.obj"

"$(OUTDIR)\LITTLEC.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 

.c{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.c{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

################################################################################
# Begin Target

# Name "LITTLEC - Win32 Release"
# Name "LITTLEC - Win32 Debug"

!IF  "$(CFG)" == "LITTLEC - Win32 Release"

!ELSEIF  "$(CFG)" == "LITTLEC - Win32 Debug"

!ENDIF 

################################################################################
# Begin Source File

SOURCE="\Documents and Settings\Peter\My Documents\LittleC\src\parser.c"

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\parser.obj" : $(SOURCE) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\parser.sbr" : $(SOURCE) "$(INTDIR)"
   $(BuildCmds)

# End Source File
################################################################################
# Begin Source File

SOURCE="\Documents and Settings\Peter\My Documents\LittleC\src\littlec.c"

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\littlec.obj" : $(SOURCE) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\littlec.sbr" : $(SOURCE) "$(INTDIR)"
   $(BuildCmds)

# End Source File
################################################################################
# Begin Source File

SOURCE="\Documents and Settings\Peter\My Documents\LittleC\src\lclib.c"

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\lclib.obj" : $(SOURCE) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\lclib.sbr" : $(SOURCE) "$(INTDIR)"
   $(BuildCmds)

# End Source File
# End Target
# End Project
################################################################################
