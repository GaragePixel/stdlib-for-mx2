//==============================================================
// Wintab API Header (Minimal Implementation)
// Implementation: iDkP from GaragePixel
// 2025-03-17 Aida 4
//==============================================================

/**
 * Purpose:
 * This minimal Wintab header avoids conflicts with Windows system 
 * headers while providing the necessary declarations for tablet
 * input processing through dynamic function loading.
 *
 * Functionality:
 * - Forward declarations of core Wintab types
 * - Function pointer type definitions for dynamic loading
 * - Packet and context data structures
 * - Constants for device information access
 *
 * Notes:
 * This implementation is designed to work with the DLL-based approach
 * used in tablet_win32.cpp, where Wintab32.dll is loaded at runtime
 * and functions are accessed via GetProcAddress. This avoids static
 * linking issues and allows the application to run even without tablet
 * drivers installed.
 *
 * Technical advantages:
 * - Avoids redefinitions of Windows types and macros
 * - Works with MinGW and MSVC build environments
 * - Minimal implementation focuses only on required functionality
 * - Careful structure definitions to maintain binary compatibility
 */

#ifndef _WINTAB_H_
#define _WINTAB_H_

#include <windows.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Wintab context options */
#define CXO_SYSTEM      0x0001
#define CXO_PEN         0x0002
#define CXO_MESSAGES    0x0004
#define CXO_MARGIN      0x8000
#define CXO_MGNINSIDE   0x4000
#define CXO_CSRMESSAGES 0x0008

/* Packet data bit masks */
#define PK_CONTEXT      0x0001
#define PK_STATUS       0x0002
#define PK_TIME         0x0004
#define PK_CHANGED      0x0008
#define PK_SERIAL_NUMBER 0x0010
#define PK_CURSOR       0x0020
#define PK_BUTTONS      0x0040
#define PK_X            0x0080
#define PK_Y            0x0100
#define PK_Z            0x0200
#define PK_NORMAL_PRESSURE 0x0400
#define PK_TANGENT_PRESSURE 0x0800
#define PK_ORIENTATION  0x1000
#define PK_ROTATION     0x2000

/* Device constants */
#define WTI_DEFCONTEXT  3
#define WTI_DEVICES     100
#define WTI_INTERFACE   1
#define IFC_NDEVICES    4
#define DVC_X           12
#define DVC_Y           13
#define DVC_NPRESSURE   15
#define DVC_NAME        1

/* Context handles */
typedef HANDLE HCTX;

/* FIX32 - Fixed point data type used by Wintab */
typedef struct tagFIX32 {
    INT16 fxSign;
    INT16 fxData;
} FIX32;

/* AXIS - Wintab axis structure */
typedef struct tagWTAXIS {
    LONG    axMin;
    LONG    axMax;
    UINT    axUnits;
    FIX32   axResolution;
} WTAXIS, *PWTAXIS, *LPWTAXIS;

/* Orientation structure */
typedef struct tagORIENTATION {
    int orAzimuth;
    int orAltitude;
    int orTwist;
} ORIENTATION, *PORIENTATION, *LPORIENTATION;

/* Wintab packet structure */
typedef struct tagPACKET {
    HCTX        pkContext;
    UINT        pkStatus;
    DWORD       pkTime;
    DWORD       pkChanged;
    UINT        pkSerialNumber;
    UINT        pkCursor;
    DWORD       pkButtons;
    LONG        pkX;
    LONG        pkY;
    LONG        pkZ;
    UINT        pkNormalPressure;
    UINT        pkTangentPressure;
    ORIENTATION pkOrientation;
} PACKET, *PPACKET, *LPPACKET;

/* Context information structure */
typedef struct tagLOGCONTEXTA {
    char    lcName[40];
    UINT    lcOptions;
    UINT    lcStatus;
    UINT    lcLocks;
    UINT    lcMsgBase;
    UINT    lcDevice;
    UINT    lcPktRate;
    DWORD   lcPktData;
    DWORD   lcPktMode;
    DWORD   lcMoveMask;
    DWORD   lcBtnDnMask;
    DWORD   lcBtnUpMask;
    LONG    lcInOrgX;
    LONG    lcInOrgY;
    LONG    lcInOrgZ;
    LONG    lcInExtX;
    LONG    lcInExtY;
    LONG    lcInExtZ;
    LONG    lcOutOrgX;
    LONG    lcOutOrgY;
    LONG    lcOutOrgZ;
    LONG    lcOutExtX;
    LONG    lcOutExtY;
    LONG    lcOutExtZ;
    FIX32   lcSensX;
    FIX32   lcSensY;
    FIX32   lcSensZ;
    BOOL    lcSysMode;
    int     lcSysOrgX;
    int     lcSysOrgY;
    int     lcSysExtX;
    int     lcSysExtY;
    FIX32   lcSysSensX;
    FIX32   lcSysSensY;
} LOGCONTEXTA, *PLOGCONTEXTA, *LPLOGCONTEXTA;

/* Function pointer types for dynamic loading - this avoids declaration conflicts */
typedef UINT (WINAPI * WTINFOA_FUNC)(UINT, UINT, LPVOID);
typedef HCTX (WINAPI * WTOPENA_FUNC)(HWND, LPLOGCONTEXTA, BOOL);
typedef BOOL (WINAPI * WTGETA_FUNC)(HCTX, LPLOGCONTEXTA);
typedef BOOL (WINAPI * WTCLOSE_FUNC)(HCTX);
typedef BOOL (WINAPI * WTENABLE_FUNC)(HCTX, BOOL);
typedef BOOL (WINAPI * WTPACKET_FUNC)(HCTX, UINT, LPVOID);
typedef BOOL (WINAPI * WTOVERLAP_FUNC)(HCTX, BOOL);
typedef BOOL (WINAPI * WTSAVE_FUNC)(HCTX, LPVOID);
typedef BOOL (WINAPI * WTCONFIG_FUNC)(HCTX, HWND);
typedef HCTX (WINAPI * WTRESTORE_FUNC)(HWND, LPVOID, BOOL);
typedef BOOL (WINAPI * WTEXTSET_FUNC)(HCTX, UINT, LPVOID);
typedef BOOL (WINAPI * WTEXTGET_FUNC)(HCTX, UINT, LPVOID);
typedef BOOL (WINAPI * WTQUEUESIZESET_FUNC)(HCTX, int);
typedef int  (WINAPI * WTDATAPEEK_FUNC)(HCTX, UINT, UINT, int, LPVOID, LPINT);
typedef int  (WINAPI * WTPACKETSGET_FUNC)(HCTX, int, LPVOID);
typedef BOOL (WINAPI * WTMGROPEN_FUNC)(HWND, UINT);
typedef BOOL (WINAPI * WTMGRCLOSE_FUNC)(HWND);
typedef HCTX (WINAPI * WTMGRDEFCONTEXT_FUNC)(BOOL);
typedef HCTX (WINAPI * WTMGRDEFCONTEXTEX_FUNC)(UINT, BOOL);
typedef int  (WINAPI * WTQUEUESIZEGET_FUNC)(HCTX);

#ifdef __cplusplus
}
#endif

#endif /* _WINTAB_H_ */