//==============================================================
// Wacom Tablet macOS Implementation
// Implementation: iDkP from GaragePixel
// 2025-03-17 Aida 4
//==============================================================

/**
 * Purpose:
 * This implementation provides macOS support for tablet devices
 * using the Cocoa NSEvent API to access tablet events directly
 * from the operating system.
 *
 * Functionality:
 * - Direct integration with macOS tablet event system
 * - Support for tablet proximity events
 * - Pressure sensitivity with curve control
 * - Pen tilt tracking
 * - Button state tracking
 * - Eraser detection
 * - Screen to tablet mapping
 *
 * Notes:
 * The implementation relies on the fact that macOS has built-in
 * tablet support. It uses an NSApplication event handler to intercept
 * tablet events before they're processed by default handlers.
 * Events are translated to a consistent API matching other platforms.
 *
 * Technical advantages:
 * - Native integration with macOS tablet event system
 * - No dependencies on external libraries or drivers
 * - Low overhead event processing
 * - Automatic device detection
 * - Consistent with system-wide tablet behavior
 */

#include astablet.h"
#import <Cocoa/Cocoa.h>
#import <AppKit/NSEvent.h>

// Global state
static float currentX = 0.0f;
static float currentY = 0.0f;
static float currentPressure = 0.0f;
static float currentTiltX = 0.0f;
static float currentTiltY = 0.0f;
static int currentButtons = 0;
static bool isEraser = false;
static bool tabletAvailable = false;
static bool eventHandlerAdded = false;
static bool hasNewEvent = false;

// Device information
static int deviceCount = 0;
static char deviceName[256] = "Tablet Device";

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

// Bezier curve calculation
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

@interface TabletEventHandler : NSObject
+ (instancetype)sharedInstance;
- (void)startMonitoring;
- (void)stopMonitoring;
@end

@implementation TabletEventHandler {
    id _eventMonitor;
}

+ (instancetype)sharedInstance {
    static TabletEventHandler *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)startMonitoring {
    if (_eventMonitor) return;
    
    // Create event monitor for tablet events
    NSEventMask eventMask = NSEventMaskTabletPoint | NSEventMaskTabletProximity | NSEventMaskLeftMouseDragged | NSEventMaskLeftMouseDown | NSEventMaskLeftMouseUp;
    
    _eventMonitor = [NSEvent addLocalMonitorForEventsMatchingMask:eventMask handler:^NSEvent *(NSEvent *event) {
        if (event.type == NSEventTypeTabletPoint) {
            currentX = event.absoluteX;
            currentY = [[NSScreen mainScreen] frame].size.height - event.absoluteY;
            currentPressure = applyCurve(event.pressure);
            currentTiltX = event.tilt.x;
            currentTiltY = event.tilt.y;
            currentButtons = (event.buttonMask & 0x01) ? 1 : 0;
            hasNewEvent = true;
            
            if (mapWidth > 0 && mapHeight > 0) {
                // Apply mapping
                currentX = mapX + (currentX / [[NSScreen mainScreen] frame].size.width) * mapWidth;
                currentY = mapY + (currentY / [[NSScreen mainScreen] frame].size.height) * mapHeight;
            }
        }
        else if (event.type == NSEventTypeTabletProximity) {
            isEraser = event.pointingDeviceType == NSPointingDeviceTypeEraser;
            tabletAvailable = event.isEnteringProximity;
            
            if (event.isEnteringProximity) {
                // Get device info when tablet comes into proximity
                strlcpy(deviceName, [event.deviceName UTF8String], sizeof(deviceName));
            }
        }
        
        return event;
    }];
}

- (void)stopMonitoring {
    if (_eventMonitor) {
        [NSEvent removeMonitor:_eventMonitor];
        _eventMonitor = nil;
    }
}

@end

// Implementation of tablet API functions
extern "C" {

bool m2_tablet_init(void) {
    // Ensure we're running on the main thread for Cocoa
    if (![NSThread isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            tabletAvailable = m2_tablet_init();
        });
        return tabletAvailable;
    }
    
    // Start monitoring for tablet events
    [[TabletEventHandler sharedInstance] startMonitoring];
    eventHandlerAdded = true;
    
    // Set default mapping to screen dimensions
    NSRect screenRect = [[NSScreen mainScreen] frame];
    mapX = 0.0f;
    mapY = 0.0f;
    mapWidth = screenRect.size.width;
    mapHeight = screenRect.size.height;
    
    // Check if any tablets are available
    NSArray *devices = [NSEvent tabletDevices];
    deviceCount = (int)[devices count];
    tabletAvailable = (deviceCount > 0);
    
    // Get device name if available
    if (tabletAvailable && [devices count] > 0) {
        id device = [devices objectAtIndex:0];
        if ([device respondsToSelector:@selector(name)]) {
            NSString *name = [device performSelector:@selector(name)];
            strlcpy(deviceName, [name UTF8String], sizeof(deviceName));
        }
    }
    
    // Set default pressure curve
    pressureCurveA = 0.0f;
    pressureCurveB = 0.0f;
    pressureCurveC = 1.0f;
    pressureCurveD = 1.0f;
    
    return tabletAvailable;
}

void m2_tablet_shutdown(void) {
    if (![NSThread isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            m2_tablet_shutdown();
        });
        return;
    }
    
    if (eventHandlerAdded) {
        [[TabletEventHandler sharedInstance] stopMonitoring];
        eventHandlerAdded = false;
    }
    
    tabletAvailable = false;
}

bool m2_tablet_update(void) {
    // Check if we have a new tablet event
    bool result = hasNewEvent;
    hasNewEvent = false;
    return result;
}

bool m2_tablet_is_available(void) {
    return tabletAvailable;
}

int m2_tablet_get_device_count(void) {
    return deviceCount;
}

const char* m2_tablet_get_device_name(int deviceIndex) {
    if (deviceIndex < deviceCount && tabletAvailable) {
        return deviceName;
    }
    return "Unknown Device";
}

float m2_tablet_get_width(void) {
    // Return active area width (default to screen width)
    return mapWidth;
}

float m2_tablet_get_height(void) {
    // Return active area height (default to screen height)
    return mapHeight;
}

float m2_tablet_get_resolution(void) {
    // Return pixels per inch (macOS is typically 72 dpi)
    return 72.0f;
}

int m2_tablet_get_pressure_levels(void) {
    // macOS typically uses 1024 pressure levels
    return 1024;
}

float m2_tablet_get_x(void) {
    return currentX;
}

float m2_tablet_get_y(void) {
    return currentY;
}

float m2_tablet_get_pressure(void) {
    return currentPressure;
}

float m2_tablet_get_tilt_x(void) {
    return currentTiltX;
}

float m2_tablet_get_tilt_y(void) {
    return currentTiltY;
}

int m2_tablet_get_button_state(int button) {
    return currentButtons;
}

bool m2_tablet_is_eraser(void) {
    return isEraser;
}

void m2_tablet_set_mapping(float x, float y, float width, float height) {
    mapX = x;
    mapY = y;
    mapWidth = width;
    mapHeight = height;
}

void m2_tablet_set_pressure_curve(float a, float b, float c, float d) {
    pressureCurveA = a;
    pressureCurveB = b;
    pressureCurveC = c;
    pressureCurveD = d;
}

}  // extern "C"