# Microsoft Visual C++ Generated NMAKE File, Format Version 2.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

!IF "$(CFG)" == ""
CFG=Win32 Debug
!MESSAGE No configuration specified.  Defaulting to Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "Win32 Release" && "$(CFG)" != "Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE on this makefile
!MESSAGE by defining the macro CFG on the command line.  For example:
!MESSAGE 
!MESSAGE NMAKE /f "LITTLEC.MAK" CFG="Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

################################################################################
# Begin Project
# PROP Target_Last_Scanned "Win32 Debug"
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "Win32 Release"

# PROP BASE Use_MFC 1
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "WinRel"
# PROP BASE Intermediate_Dir "WinRel"
# PROP Use_MFC 1
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "WinRel"
# PROP Intermediate_Dir "WinRel"
OUTDIR=.\WinRel
INTDIR=.\WinRel

ALL : $(OUTDIR)/"LITTLEC.exe" $(OUTDIR)/"LITTLEC.bsc"

$(OUTDIR) : 
    if not exist $(OUTDIR)/nul mkdir $(OUTDIR)

# ADD BASE CPP /nologo /MT /W3 /GX /YX /Ox /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_DOS" /D "_MBCS" /FR /c
# ADD CPP /nologo /MT /W3 /GX /YX /Ox /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_DOS" /D "_MBCS" /FR /c
CPP_PROJ=/nologo /MT /W3 /GX /YX /Ox /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D\
 "_DOS" /D "_MBCS" /FR$(INTDIR)/ /Fp$(OUTDIR)/"LITTLEC.pch" /Fo$(INTDIR)/ /c 
CPP_OBJS=.\WinRel/
# ADD BASE RSC /l 0x1409 /d "NDEBUG"
# ADD RSC /l 0x1409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o$(OUTDIR)/"LITTLEC.bsc" 
BSC32_SBRS= \
	$(INTDIR)/"parser.sbr" \
	$(INTDIR)/"littlec.sbr" \
	$(INTDIR)/"lclib.sbr"

$(OUTDIR)/"LITTLEC.bsc" : $(OUTDIR)  $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
# ADD BASE LINK32 oldnames.lib /NOLOGO /STACK:0x5120 /SUBSYSTEM:console /MACHINE:IX86
# ADD LINK32 oldnames.lib /NOLOGO /STACK:0x5120 /SUBSYSTEM:console /MACHINE:IX86
LINK32_FLAGS=oldnames.lib /NOLOGO /STACK:0x5120 /SUBSYSTEM:console\
 /INCREMENTAL:no /PDB:$(OUTDIR)/"LITTLEC.pdb" /MACHINE:IX86\
 /OUT:$(OUTDIR)/"LITTLEC.exe" 
DEF_FILE=
LINK32_OBJS= \
	$(INTDIR)/"parser.obj" \
	$(INTDIR)/"littlec.obj" \
	$(INTDIR)/"lclib.obj"

$(OUTDIR)/"LITTLEC.exe" : $(OUTDIR)  $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "Win32 Debug"

# PROP BASE Use_MFC 1
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "WinDebug"
# PROP BASE Intermediate_Dir "WinDebug"
# PROP Use_MFC 1
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "WinDebug"
# PROP Intermediate_Dir "WinDebug"
OUTDIR=.\WinDebug
INTDIR=.\WinDebug

ALL : $(OUTDIR)/"LITTLEC.exe" $(OUTDIR)/"LITTLEC.bsc"

$(OUTDIR) : 
    if not exist $(OUTDIR)/nul mkdir $(OUTDIR)

# ADD BASE CPP /nologo /MT /W3 /GX /Zi /YX /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_DOS" /D "_MBCS" /FR /c
# ADD CPP /nologo /MT /W3 /GX /Zi /YX /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_DOS" /D "_MBCS" /FR /c
CPP_PROJ=/nologo /MT /W3 /GX /Zi /YX /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "_DOS" /D "_MBCS" /FR$(INTDIR)/ /Fp$(OUTDIR)/"LITTLEC.pch" /Fo$(INTDIR)/\
 /Fd$(OUTDIR)/"LITTLEC.pdb" /c 
CPP_OBJS=.\WinDebug/
# ADD BASE RSC /l 0x1409 /d "_DEBUG"
# ADD RSC /l 0x1409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o$(OUTDIR)/"LITTLEC.bsc" 
BSC32_SBRS= \
	$(INTDIR)/"parser.sbr" \
	$(INTDIR)/"littlec.sbr" \
	$(INTDIR)/"lclib.sbr"

$(OUTDIR)/"LITTLEC.bsc" : $(OUTDIR)  $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
# ADD BASE LINK32 oldnames.lib /NOLOGO /STACK:0x5120 /SUBSYSTEM:console /DEBUG /MACHINE:IX86
# ADD LINK32 oldnames.lib /NOLOGO /STACK:0x5120 /SUBSYSTEM:console /DEBUG /MACHINE:IX86
LINK32_FLAGS=oldnames.lib /NOLOGO /STACK:0x5120 /SUBSYSTEM:console\
 /INCREMENTAL:yes /PDB:$(OUTDIR)/"LITTLEC.pdb" /DEBUG /MACHINE:IX86\
 /OUT:$(OUTDIR)/"LITTLEC.exe" 
DEF_FILE=
LINK32_OBJS= \
	$(INTDIR)/"parser.obj" \
	$(INTDIR)/"littlec.obj" \
	$(INTDIR)/"lclib.obj"

$(OUTDIR)/"LITTLEC.exe" : $(OUTDIR)  $(DEF_FILE) $(LINK32_OBJS)
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

################################################################################
# Begin Group "Source Files"

################################################################################
# Begin Source File

SOURCE="\Documents and Settings\Peter\My Documents\LittleC\src\parser.c"

$(INTDIR)/"parser.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE="\Documents and Settings\Peter\My Documents\LittleC\src\littlec.c"

$(INTDIR)/"littlec.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
################################################################################
# Begin Source File

SOURCE="\Documents and Settings\Peter\My Documents\LittleC\src\lclib.c"

$(INTDIR)/"lclib.obj" :  $(SOURCE)  $(INTDIR)
   $(CPP) $(CPP_PROJ)  $(SOURCE) 

# End Source File
# End Group
# End Project
################################################################################
