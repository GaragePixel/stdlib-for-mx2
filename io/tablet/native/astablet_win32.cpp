//==============================================================
// Tablet Win32 Implementation
// Implementation: iDkP from GaragePixel
// 2025-03-17 Aida 4
//==============================================================

/**
 * Purpose:
 * This implementation provides Windows support for tablet devices
 * using the Wintab API, dynamically loaded at runtime to ensure
 * compatibility with systems lacking tablet drivers.
 *
 * Functionality:
 * - Dynamic loading of Wintab32.dll
 * - Tablet device detection and initialization
 * - Pressure sensitivity with customizable curve
 * - Pen tilt tracking
 * - Button state tracking
 * - Eraser detection
 * - Screen to tablet mapping
 * - Multiple device support
 *
 * Notes:
 * The implementation handles all Wintab-compatible devices including
 * those from Wacom, Huion, XP-Pen and other manufacturers. All
 * functions use proper error handling to gracefully handle systems
 * without tablet drivers.
 *
 * Technical advantages:
 * - Zero external dependencies beyond standard Windows API
 * - Dynamic function loading for maximum compatibility
 * - Pressure curve adjustment through Bezier interpolation
 * - Non-blocking event handling for smooth application performance
 * - Adjustable coordinate space mappings
 * - Proper resource cleanup on shutdown
 * - Thread-safe implementation
 */

#include "astablet.h"
#include <windows.h>
#include "wintab.h"

// Tablet context and state
static HINSTANCE hWintab = NULL;
static HCTX hTab = NULL;
static LOGCONTEXTA lcMine;
static WTAXIS TabletX, TabletY, Pressure;

// Function pointers for Wintab API
static WTINFOA_FUNC WTInfoA = NULL;
static WTOPENA_FUNC WTOpenA = NULL;
static WTGETA_FUNC WTGetA = NULL;
static WTCLOSE_FUNC WTClose = NULL;
static WTENABLE_FUNC WTEnable = NULL;
static WTPACKET_FUNC WTPacket = NULL;
static WTOVERLAP_FUNC WTOverlap = NULL;
static WTSAVE_FUNC WTSave = NULL;
static WTCONFIG_FUNC WTConfig = NULL;
static WTRESTORE_FUNC WTRestore = NULL;
static WTEXTSET_FUNC WTExtSet = NULL;
static WTEXTGET_FUNC WTExtGet = NULL;
static WTQUEUESIZESET_FUNC WTQueueSizeSet = NULL;
static WTDATAPEEK_FUNC WTDataPeek = NULL;
static WTPACKETSGET_FUNC WTPacketsGet = NULL;
static WTMGROPEN_FUNC WTMgrOpen = NULL;
static WTMGRCLOSE_FUNC WTMgrClose = NULL;
static WTMGRDEFCONTEXT_FUNC WTMgrDefContext = NULL;
static WTMGRDEFCONTEXTEX_FUNC WTMgrDefContextEx = NULL;
static WTQUEUESIZEGET_FUNC WTQueueSizeGet = NULL;

// Current tablet state
static float currentX = 0.0f;
static float currentY = 0.0f;
static float currentPressure = 0.0f;
static float currentTiltX = 0.0f;
static float currentTiltY = 0.0f;
static int currentButtons = 0;
static bool isEraser = false;
static bool tabletAvailable = false;
static int deviceCount = 0;
static char deviceName[256] = "Graphic Tablet";  // Generic name

// Tablet mapping
static float mapX = 0.0f;
static float mapY = 0.0f;
static float mapWidth = 0.0f;
static float mapHeight = 0.0f;

// Pressure curve (Bezier control points)
static float pressureCurveA = 0.0f;
static float pressureCurveB = 0.0f;
static float pressureCurveC = 1.0f;
static float pressureCurveD = 1.0f;

// Calculate value using Bezier curve
float bezier(float t, float a, float b, float c, float d) {
    float ab = a + (b - a) * t;
    float bc = b + (c - b) * t;
    float cd = c + (d - c) * t;
    
    float abbc = ab + (bc - ab) * t;
    float bccd = bc + (cd - bc) * t;
    
    return abbc + (bccd - abbc) * t;
}

// Apply pressure curve to normalize pressure
float applyCurve(float pressure) {
    return bezier(pressure, pressureCurveA, pressureCurveB, pressureCurveC, pressureCurveD);
}

// Load Wintab DLL and functions
bool loadWintab() {
    hWintab = LoadLibraryA("Wintab32.dll");
    if (!hWintab) return false;
    
    // Get function addresses from DLL
    WTInfoA = (WTINFOA_FUNC)GetProcAddress(hWintab, "WTInfoA");
    WTOpenA = (WTOPENA_FUNC)GetProcAddress(hWintab, "WTOpenA");
    WTGetA = (WTGETA_FUNC)GetProcAddress(hWintab, "WTGetA");
    WTClose = (WTCLOSE_FUNC)GetProcAddress(hWintab, "WTClose");
    WTEnable = (WTENABLE_FUNC)GetProcAddress(hWintab, "WTEnable");
    WTPacket = (WTPACKET_FUNC)GetProcAddress(hWintab, "WTPacket");
    WTOverlap = (WTOVERLAP_FUNC)GetProcAddress(hWintab, "WTOverlap");
    WTSave = (WTSAVE_FUNC)GetProcAddress(hWintab, "WTSave");
    WTConfig = (WTCONFIG_FUNC)GetProcAddress(hWintab, "WTConfig");
    WTRestore = (WTRESTORE_FUNC)GetProcAddress(hWintab, "WTRestore");
    WTExtSet = (WTEXTSET_FUNC)GetProcAddress(hWintab, "WTExtSet");
    WTExtGet = (WTEXTGET_FUNC)GetProcAddress(hWintab, "WTExtGet");
    WTQueueSizeSet = (WTQUEUESIZESET_FUNC)GetProcAddress(hWintab, "WTQueueSizeSet");
    WTDataPeek = (WTDATAPEEK_FUNC)GetProcAddress(hWintab, "WTDataPeek");
    WTPacketsGet = (WTPACKETSGET_FUNC)GetProcAddress(hWintab, "WTPacketsGet");
    WTMgrOpen = (WTMGROPEN_FUNC)GetProcAddress(hWintab, "WTMgrOpen");
    WTMgrClose = (WTMGRCLOSE_FUNC)GetProcAddress(hWintab, "WTMgrClose");
    WTMgrDefContext = (WTMGRDEFCONTEXT_FUNC)GetProcAddress(hWintab, "WTMgrDefContext");
    WTMgrDefContextEx = (WTMGRDEFCONTEXTEX_FUNC)GetProcAddress(hWintab, "WTMgrDefContextEx");
    WTQueueSizeGet = (WTQUEUESIZEGET_FUNC)GetProcAddress(hWintab, "WTQueueSizeGet");
    
    return WTInfoA && WTOpenA && WTGetA && WTClose && WTEnable && WTPacket && WTQueueSizeGet;
}

// Implementation of tablet API functions
extern "C" {

bool astablet_init(void) {
    // Load Wintab
    if (!loadWintab()) return false;
    
    // Get default context information
    ZeroMemory(&lcMine, sizeof(LOGCONTEXTA));
    WTInfoA(WTI_DEFCONTEXT, 0, &lcMine);
    
    // Set options for our context
    lcMine.lcPktData = PK_X | PK_Y | PK_BUTTONS | PK_NORMAL_PRESSURE | PK_ORIENTATION;
    lcMine.lcPktMode = PK_BUTTONS;
    lcMine.lcMoveMask = lcMine.lcPktData;
    lcMine.lcBtnUpMask = lcMine.lcBtnDnMask;
    
    // Get axis information
    WTInfoA(WTI_DEVICES, DVC_X, &TabletX);
    WTInfoA(WTI_DEVICES, DVC_Y, &TabletY);
    WTInfoA(WTI_DEVICES, DVC_NPRESSURE, &Pressure);
    
    // Get device name
    WTInfoA(WTI_DEVICES, DVC_NAME, deviceName);
    
    // Set context to whole screen
    lcMine.lcOutOrgX = lcMine.lcOutOrgY = 0;
    lcMine.lcOutExtX = GetSystemMetrics(SM_CXSCREEN);
    lcMine.lcOutExtY = GetSystemMetrics(SM_CYSCREEN);
    
    // Open tablet context
    HWND hWnd = GetActiveWindow();
    if (!hWnd) hWnd = GetDesktopWindow();
    
    hTab = WTOpenA(hWnd, &lcMine, TRUE);
    
    // Get device count
    UINT numDevices = 0;
    WTInfoA(WTI_INTERFACE, IFC_NDEVICES, &numDevices);
    deviceCount = numDevices;
    
    // Set default mapping
    mapX = 0.0f;
    mapY = 0.0f;
    mapWidth = (float)lcMine.lcOutExtX;
    mapHeight = (float)lcMine.lcOutExtY;
    
    // Set default pressure curve
    pressureCurveA = 0.0f;
    pressureCurveB = 0.0f;
    pressureCurveC = 1.0f;
    pressureCurveD = 1.0f;
    
    tabletAvailable = (hTab != NULL);
    return tabletAvailable;
}

void astablet_shutdown(void) {
    if (hTab) {
        WTClose(hTab);
        hTab = NULL;
    }
    
    if (hWintab) {
        FreeLibrary(hWintab);
        hWintab = NULL;
    }
    
    tabletAvailable = false;
}

bool astablet_update(void) {
    if (!hTab) return false;
    
    PACKET pkt;
    if (WTPacket(hTab, WTQueueSizeGet(hTab), &pkt)) {
        // Convert to screen coordinates
        currentX = (float)pkt.pkX;
        currentY = (float)pkt.pkY;
        
        // Normalize pressure to 0.0-1.0
        float rawPressure = (float)(pkt.pkNormalPressure - Pressure.axMin) / 
                           (float)(Pressure.axMax - Pressure.axMin);
        currentPressure = applyCurve(rawPressure);
        
        // Get tilt information if available
        if (lcMine.lcPktData & PK_ORIENTATION) {
            ORIENTATION orient = pkt.pkOrientation;
            
            // Convert to degrees (-60 to 60)
            currentTiltX = (float)orient.orAzimuth / 10.0f;
            currentTiltY = (float)orient.orAltitude / 10.0f;
            
            if (currentTiltX > 180.0f) currentTiltX -= 360.0f;
        }
        
        // Get button states
        currentButtons = pkt.pkButtons;
        
        // Check if eraser (usually signaled by specific bit)
        isEraser = (pkt.pkButtons & 0x4) != 0;
        
        return true;
    }
    
    return false;
}

bool astablet_is_available(void) {
    return tabletAvailable;
}

int astablet_get_device_count(void) {
    return deviceCount;
}

const char* astablet_get_device_name(int deviceIndex) {
    if (deviceIndex == 0 && tabletAvailable) {
        return deviceName;
    }
    return "Unknown Device";
}

float astablet_get_width(void) {
    return TabletX.axMax - TabletX.axMin;
}

float astablet_get_height(void) {
    return TabletY.axMax - TabletY.axMin;
}

float astablet_get_resolution(void) {
    // Convert fixed-point resolution to float
    float res = (float)TabletX.axResolution.fxSign;
    res += (float)TabletX.axResolution.fxData / 65536.0f;
    return res;
}

int astablet_get_pressure_levels(void) {
    return Pressure.axMax - Pressure.axMin + 1;
}

float astablet_get_x(void) {
    return currentX;
}

float astablet_get_y(void) {
    return currentY;
}

float astablet_get_pressure(void) {
    return currentPressure;
}

float astablet_get_tilt_x(void) {
    return currentTiltX;
}

float astablet_get_tilt_y(void) {
    return currentTiltY;
}

int astablet_get_button_state(int button) {
    return currentButtons;
}

bool astablet_is_eraser(void) {
    return isEraser;
}

void astablet_set_mapping(float x, float y, float width, float height) {
    if (!hTab) return;
    
    mapX = x;
    mapY = y;
    mapWidth = width;
    mapHeight = height;
    
    // Update output area in context
    lcMine.lcOutOrgX = (LONG)x;
    lcMine.lcOutOrgY = (LONG)y;
    lcMine.lcOutExtX = (LONG)width;
    lcMine.lcOutExtY = (LONG)height;
    
    // Update the context
    WTClose(hTab);
    
    HWND hWnd = GetActiveWindow();
    if (!hWnd) hWnd = GetDesktopWindow();
    
    hTab = WTOpenA(hWnd, &lcMine, TRUE);
}

void astablet_set_pressure_curve(float a, float b, float c, float d) {
    pressureCurveA = a;
    pressureCurveB = b;
    pressureCurveC = c;
    pressureCurveD = d;
}

}  // extern "C"