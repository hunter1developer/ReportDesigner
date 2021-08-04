###############################################################
#  Define type of binary, used packages, project defines and  #
#  include paths if needed                                    #
###############################################################

ISPACKAGE=FALSE
VCLPACKAGES=
DEFINES=$(DBVER)
INCLUDEPATH=$(RO)\Source;$(DA)\Source;$(RBuilder)
UNITINCLUDEPATH=..\Common;..\VersatileDataServer\ReportDataModules;$(LOCALCOMP)\NativeXml\src;..\VersatileReportService;$(LOCALCOMP)\ZeiCommon;$(LOCALCOMP)\ZeiCommon\Dec2009;$(LOCALCOMP)\ZeiCommon\Cipher;$(LOCALCOMP)\ZeiCommon\DCPcrypt;$(LOCALCOMP)\ZeiCommon\DCPcrypt\Ciphers;$(LOCALCOMP)\ZeiCommon\DCPcrypt\Hashes;$(SvCom)\RunTime;$(SvCom)\Experts;$(SvCom)\DesignTime;$(RO)\Source;$(RO)\Source\RODEC;$(RO)\Source\CodeGen;$(RO)\Source\ZLib;$(DA)\Source;$(DA)\Source\Server;$(DA)\Source\Drivers;$(DA)\Source\Legacy;$(SDAC)\source;$(ODAC)\source;$(SDACLIB);$(ODACLib);$(DevExpLib);$(RBuilder)

###############################################################
!include ..\local_rules.inc
!include ..\make_settings.inc
###############################################################

PROJECTS=ZasioVCloudReportManager.res ZasioVCloudReportManager.exe
default:: $(PROJECTS)

###############################################################

!if $(ARCHITECTURE)==X32
ZasioVCloudReportManager.res:: res\ZasioVCloudReportManager.rc
   $(INCBLD)
   $(RCC) -foZasioVCloudReportManager.res
!endif

!if $(ARCHITECTURE)==X64
ZasioVCloudReportManager.res:: res\ZasioVCloudReportManagerx64.rc
   $(INCBLD)
   $(RCC) -foZasioVCloudReportManager.res
!endif


ZasioVCloudReportManager.exe:: ZasioVCloudReportManager.dpr
   $(BACKUPDOF)
   $(BACKUPCFG)
   $(MESSAGE)
   $(DCC)
   $(CHECKIN)
   $(RESTOREDOF)
   $(RESTORECFG)

###############################################################

