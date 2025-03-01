
#rem wonkeydoc Raspberry Pi GPIO lib pigpio
#end
Namespace stdlib.platforms.raspberry.pigpio

'
' Import from Raspberry OS system (old version)
'
'#Import "<pigpio.h>"
'#Import "<libpigpio.a>"

'
' Importing from sources
'
#Import "pigpio/pigpio.h"
#Import "pigpio/pigpio.c"

#Import "pigpio/command.h"
#Import "pigpio/command.c"

Extern

'
' Macro Functions:
'
Function PI_NTFY_FLAGS_BIT:Int(x:Int)
Function PI_SPI_FLAGS_BITLEN:Int(x:Int)
Function PI_SPI_FLAGS_RX_LSB:Int(x:Int)
Function PI_SPI_FLAGS_TX_LSB:Int(x:Int)
Function PI_SPI_FLAGS_3WREN:Int(x:Int)
Function PI_SPI_FLAGS_3WIRE:Int(x:Int)
Function PI_SPI_FLAGS_AUX_SPI:Int(x:Int)
Function PI_SPI_FLAGS_RESVD:Int(x:Int)
Function PI_SPI_FLAGS_CSPOLS:Int(x:Int)
Function PI_SPI_FLAGS_MODE:Int(x:Int)


'
' Aliases:
'
Alias gpioAlertFunc_t:Void(gpio:Int, level:Int, tick:Int)
Alias gpioAlertFuncEx_t:Void(gpio:Int, level:Int, tick:Int, userdata:Void Ptr)
Alias eventFunc_t:Void(event:Int, tick:Int)
Alias eventFuncEx_t:Void(event:Int, tick:Int, userdata:Void Ptr)
Alias gpioISRFunc_t:Void(gpio:Int, level:Int, tick:Int)
Alias gpioISRFuncEx_t:Void(gpio:Int, level:Int, tick:Int, userdata:Void Ptr)
Alias gpioTimerFunc_t:Void()
Alias gpioTimerFuncEx_t:Void(userdata:Void Ptr)
Alias gpioSignalFunc_t:Void(signum:Int)
Alias gpioSignalFuncEx_t:Void(signum:Int, userdata:Void Ptr)
Alias gpioGetSamplesFunc_t:Void(samples:gpioSample_t Ptr, numSamples:Int)
Alias gpioGetSamplesFuncEx_t:Void(samples:gpioSample_t Ptr, numSamples:Int, userdata:Void Ptr)
Alias gpioThreadFunc_t:Void Ptr(Void Ptr)


'
' Functions:
'
Function gpioInitialise:Int()
Function gpioTerminate:Void()
Function gpioSetMode:Int(gpio:Int, mode:Int)
Function gpioGetMode:Int(gpio:Int)
Function gpioSetPullUpDown:Int(gpio:Int, pud:Int)
Function gpioRead:Int(gpio:Int)
Function gpioWrite:Int(gpio:Int, level:Int)
Function gpioPWM:Int(user_gpio:Int, dutycycle:Int)
Function gpioGetPWMdutycycle:Int(user_gpio:Int)
Function gpioSetPWMrange:Int(user_gpio:Int, range:Int)
Function gpioGetPWMrange:Int(user_gpio:Int)
Function gpioGetPWMrealRange:Int(user_gpio:Int)
Function gpioSetPWMfrequency:Int(user_gpio:Int, frequency:Int)
Function gpioGetPWMfrequency:Int(user_gpio:Int)
Function gpioServo:Int(user_gpio:Int, pulsewidth:Int)
Function gpioGetServoPulsewidth:Int(user_gpio:Int)
Function gpioSetAlertFunc:Int(user_gpio:Int, f:gpioAlertFunc_t)
Function gpioSetAlertFuncEx:Int(user_gpio:Int, f:gpioAlertFuncEx_t, userdata:Void Ptr)
Function gpioSetISRFunc:Int(gpio:Int, edge:Int, timeout:Int, f:gpioISRFunc_t)
Function gpioSetISRFuncEx:Int(gpio:Int, edge:Int, timeout:Int, f:gpioISRFuncEx_t, userdata:Void Ptr)
Function gpioNotifyOpen:Int()
Function gpioNotifyOpenWithSize:Int(bufSize:Int)
Function gpioNotifyBegin:Int(handle:Int, bits:Int)
Function gpioNotifyPause:Int(handle:Int)
Function gpioNotifyClose:Int(handle:Int)
Function gpioWaveClear:Int()
Function gpioWaveAddNew:Int()
Function gpioWaveAddGeneric:Int(numPulses:Int, pulses:gpioPulse_t Ptr)
Function gpioWaveAddSerial:Int(user_gpio:Int, baud:Int, data_bits:Int, stop_bits:Int, offset:Int, numBytes:Int, str:CString)
Function gpioWaveCreate:Int()
Function gpioWaveCreatePad:Int(pctCB:Int, pctBOOL:Int, pctTOOL:Int)
Function gpioWaveDelete:Int(wave_id:Int)
Function gpioWaveTxSend:Int(wave_id:Int, wave_mode:Int)
Function gpioWaveChain:Int(buf:CString, bufSize:Int)
Function gpioWaveTxAt:Int()
Function gpioWaveTxBusy:Int()
Function gpioWaveTxStop:Int()
Function gpioWaveGetMicros:Int()
Function gpioWaveGetHighMicros:Int()
Function gpioWaveGetMaxMicros:Int()
Function gpioWaveGetPulses:Int()
Function gpioWaveGetHighPulses:Int()
Function gpioWaveGetMaxPulses:Int()
Function gpioWaveGetCbs:Int()
Function gpioWaveGetHighCbs:Int()
Function gpioWaveGetMaxCbs:Int()
Function gpioSerialReadOpen:Int(user_gpio:Int, baud:Int, data_bits:Int)
Function gpioSerialReadInvert:Int(user_gpio:Int, invert:Int)
Function gpioSerialRead:Int(user_gpio:Int, buf:Void Ptr, bufSize:ULong)
Function gpioSerialReadClose:Int(user_gpio:Int)
Function i2cOpen:Int(i2cBus:Int, i2cAddr:Int, i2cFlags:Int)
Function i2cClose:Int(handle:Int)
Function i2cWriteQuick:Int(handle:Int, bit:Int)
Function i2cWriteByte:Int(handle:Int, bVal:Int)
Function i2cReadByte:Int(handle:Int)
Function i2cWriteByteData:Int(handle:Int, i2cReg:Int, bVal:Int)
Function i2cWriteWordData:Int(handle:Int, i2cReg:Int, wVal:Int)
Function i2cReadByteData:Int(handle:Int, i2cReg:Int)
Function i2cReadWordData:Int(handle:Int, i2cReg:Int)
Function i2cProcessCall:Int(handle:Int, i2cReg:Int, wVal:Int)
Function i2cWriteBlockData:Int(handle:Int, i2cReg:Int, buf:CString, count:Int)
Function i2cReadBlockData:Int(handle:Int, i2cReg:Int, buf:CString)
Function i2cBlockProcessCall:Int(handle:Int, i2cReg:Int, buf:CString, count:Int)
Function i2cReadI2CBlockData:Int(handle:Int, i2cReg:Int, buf:CString, count:Int)
Function i2cWriteI2CBlockData:Int(handle:Int, i2cReg:Int, buf:CString, count:Int)
Function i2cReadDevice:Int(handle:Int, buf:CString, count:Int)
Function i2cWriteDevice:Int(handle:Int, buf:CString, count:Int)
Function i2cSwitchCombined:Void(setting:Int)
Function i2cSegments:Int(handle:Int, segs:pi_i2c_msg_t Ptr, numSegs:Int)
Function i2cZip:Int(handle:Int, inBuf:CString, inLen:Int, outBuf:CString, outLen:Int)
Function bbI2COpen:Int(SDA:Int, SCL:Int, baud:Int)
Function bbI2CClose:Int(SDA:Int)
Function bbI2CZip:Int(SDA:Int, inBuf:CString, inLen:Int, outBuf:CString, outLen:Int)
Function bscXfer:Int(bsc_xfer:bsc_xfer_t Ptr)
Function bbSPIOpen:Int(CS:Int, MISO:Int, MOSI:Int, SCLK:Int, baud:Int, spiFlags:Int)
Function bbSPIClose:Int(CS:Int)
Function bbSPIXfer:Int(CS:Int, inBuf:CString, outBuf:CString, count:Int)
Function spiOpen:Int(spiChan:Int, baud:Int, spiFlags:Int)
Function spiClose:Int(handle:Int)
Function spiRead:Int(handle:Int, buf:CString, count:Int)
Function spiWrite:Int(handle:Int, buf:CString, count:Int)
Function spiXfer:Int(handle:Int, txBuf:CString, rxBuf:CString, count:Int)
Function serOpen:Int(sertty:CString, baud:Int, serFlags:Int)
Function serClose:Int(handle:Int)
Function serWriteByte:Int(handle:Int, bVal:Int)
Function serReadByte:Int(handle:Int)
Function serWrite:Int(handle:Int, buf:CString, count:Int)
Function serRead:Int(handle:Int, buf:CString, count:Int)
Function serDataAvailable:Int(handle:Int)
Function gpioTrigger:Int(user_gpio:Int, pulseLen:Int, level:Int)
Function gpioSetWatchdog:Int(user_gpio:Int, timeout:Int)
Function gpioNoiseFilter:Int(user_gpio:Int, steady:Int, active:Int)
Function gpioGlitchFilter:Int(user_gpio:Int, steady:Int)
Function gpioSetGetSamplesFunc:Int(f:gpioGetSamplesFunc_t, bits:Int)
Function gpioSetGetSamplesFuncEx:Int(f:gpioGetSamplesFuncEx_t, bits:Int, userdata:Void Ptr)
Function gpioSetTimerFunc:Int(timer:Int, millis:Int, f:gpioTimerFunc_t)
Function gpioSetTimerFuncEx:Int(timer:Int, millis:Int, f:gpioTimerFuncEx_t, userdata:Void Ptr)
Function gpioStartThread:Void Ptr(f:gpioThreadFunc_t, userdata:Void Ptr)
Function gpioStopThread:Void(pth:Void Ptr)
Function gpioStoreScript:Int(script:CString)
Function gpioRunScript:Int(script_id:Int, numPar:Int, param:Int Ptr)
Function gpioRunScript:Int(script_id:Int, numPar:Int, param:Int Ptr)
Function gpioUpdateScript:Int(script_id:Int, numPar:Int, param:Int Ptr)
Function gpioScriptStatus:Int(script_id:Int, param:Int Ptr)
Function gpioStopScript:Int(script_id:Int)
Function gpioDeleteScript:Int(script_id:Int)
Function gpioSetSignalFunc:Int(signum:Int, f:gpioSignalFunc_t)
Function gpioSetSignalFuncEx:Int(signum:Int, f:gpioSignalFuncEx_t, userdata:Void Ptr)
Function gpioRead_Bits_0_31:Int()
Function gpioRead_Bits_32_53:Int()
Function gpioWrite_Bits_0_31_Clear:Int(bits:Int)
Function gpioWrite_Bits_32_53_Clear:Int(bits:Int)
Function gpioWrite_Bits_0_31_Set:Int(bits:Int)
Function gpioWrite_Bits_32_53_Set:Int(bits:Int)
Function gpioHardwareClock:Int(gpio:Int, clkfreq:Int)
Function gpioHardwarePWM:Int(gpio:Int, PWMfreq:Int, PWMduty:Int)
Function gpioTime:Int(timetype:Int, seconds:Int Ptr, micros:Int Ptr)
Function gpioSleep:Int(timetype:Int, seconds:Int, micros:Int)
Function gpioDelay:Int(micros:Int)
Function gpioTick:Int()
Function gpioHardwareRevision:Int()
Function gpioVersion:Int()
Function gpioGetPad:Int(pad:Int)
Function gpioSetPad:Int(pad:Int, padStrength:Int)
Function eventMonitor:Int(handle:Int, bits:Int)
Function eventSetFunc:Int(event:Int, f:eventFunc_t)
Function eventSetFuncEx:Int(event:Int, f:eventFuncEx_t, userdata:Void Ptr)
Function eventTrigger:Int(event:Int)
Function shell:Int(scriptName:CString, scriptString:CString)
Function fileOpen:Int(file:CString, mode:Int)
Function fileClose:Int(handle:Int)
Function fileWrite:Int(handle:Int, buf:CString, count:Int)
Function fileRead:Int(handle:Int, buf:CString, count:Int)
Function fileSeek:Int(handle:Int, seekOffset:Int, seekFrom:Int)
Function fileList:Int(fpat:CString, buf:CString, count:Int)
Function gpioCfgBufferSize:Int(cfgMillis:Int)
Function gpioCfgClock:Int(cfgMicros:Int, cfgPeripheral:Int, cfgSource:Int)
Function gpioCfgDMAchannel:Int(DMAchannel:Int)
Function gpioCfgDMAchannels:Int(primaryChannel:Int, secondaryChannel:Int)
Function gpioCfgPermissions:Int(updateMask:ULong)
Function gpioCfgSocketPort:Int(port:Int)
Function gpioCfgInterfaces:Int(ifFlags:Int)
Function gpioCfgMemAlloc:Int(memAllocMode:Int)
Function gpioCfgNetAddr:Int(numSockAddr:Int, sockAddr:Int Ptr)
Function gpioCfgGetInternals:Int()
Function gpioCfgSetInternals:Int(cfgVal:Int)
Function gpioCustom1:Int(arg1:Int, arg2:Int, argx:CString, argc:Int)
Function gpioCustom2:Int(arg1:Int, argx:CString, argc:Int, retBuf:CString, retMax:Int)
Function rawWaveAddSPI:Int(spi:rawSPI_t Ptr, offset:Int, spiSS:Int, buf:CString, spiTxBits:Int, spiBitFirst:Int, spiBitLast:Int, spiBits:Int)
Function rawWaveAddGeneric:Int(numPulses:Int, pulses:rawWave_t Ptr)
Function rawWaveCB:Int()
Function rawWaveCBAdr:rawCbs_t Ptr(cbNum:Int)
Function rawWaveGetOOL:Int(pos:Int)
Function rawWaveSetOOL:Void(pos:Int, lVal:Int)
Function rawWaveGetOut:Int(pos:Int)
Function rawWaveSetOut:Void(pos:Int, lVal:Int)
Function rawWaveGetIn:Int(pos:Int)
Function rawWaveSetIn:Void(pos:Int, lVal:Int)
Function rawWaveInfo:rawWaveInfo_t(wave_id:Int)
Function getBitInBytes:Int(bitPos:Int, buf:CString, numBits:Int)
Function putBitInBytes:Void(bitPos:Int, buf:CString, bit:Int)
Function time_time:Double()
Function time_sleep:Void(seconds:Double)
Function rawDumpWave:Void()
Function rawDumpScript:Void(script_id:Int)


'
' Structures:
'
Struct gpioHeader_t
	Field func:UShort
	Field size:UShort
End


Struct gpioExtent_t
	Field size:ULong
	Field ptr_:Void Ptr = "ptr"
	Field data:Int
End


Struct gpioSample_t
	Field tick:Int
	Field level:Int
End


Struct gpioReport_t
	Field seqno:UShort
	Field flags:UShort
	Field tick:Int
	Field level:Int
End


Struct gpioPulse_t
	Field gpioOn:Int
	Field gpioOff:Int
	Field usDelay:Int
End


Struct rawWave_t
	Field gpioOn:Int
	Field gpioOff:Int
	Field usDelay:Int
	Field flags:Int
End


Struct rawWaveInfo_t
	Field botCB:UShort
	Field topCB:UShort
	Field botOOL:UShort
	Field topOOL:UShort
	Field deleted:UShort
	Field numCB:UShort
	Field numBOOL:UShort
	Field numTOOL:UShort
End


Struct rawSPI_t
	Field clk:Int
	Field mosi:Int
	Field miso:Int
	Field ss_pol:Int
	Field ss_us:Int
	Field clk_pol:Int
	Field clk_pha:Int
	Field clk_us:Int
End


Struct rawCbs_t
	Field info:Int
	Field src:Int
	Field dst:Int
	Field length:Int
	Field stride:Int
	Field next_:Int = "next"
	Field pad:Int[]
End


Struct pi_i2c_msg_t
	Field addr:UShort
	Field flags:UShort
	Field len:UShort
	Field buf:UByte Ptr
End


Struct bsc_xfer_t
	Field control:Int
	Field rxCnt:Int
	Field rxBuf:Byte[]
	Field txCnt:Int
	Field txBuf:Byte[]
End




'
' Constants:
'
Const PIGPIO_VERSION:Int
Const PI_INPFIFO:CString ' "/dev/pigpio"
Const PI_OUTFIFO:CString ' "/dev/pigout"
Const PI_ERRFIFO:CString ' "/dev/pigerr"
Const PI_ENVPORT:CString ' "PIGPIO_PORT"
Const PI_ENVADDR:CString ' "PIGPIO_ADDR"
Const PI_LOCKFILE:CString ' "/var/run/pigpio.pid"
Const PI_I2C_COMBINED:CString ' "/sys/module/i2c_bcm2708/parameters/combined"
Const WAVE_FLAG_READ:Int
Const WAVE_FLAG_TICK:Int
Const BSC_FIFO_SIZE:Int
Const PI_MIN_GPIO:Int
Const PI_MAX_GPIO:Int
Const PI_MAX_USER_GPIO:Int
Const PI_OFF:Int
Const PI_ON:Int
Const PI_CLEAR:Int
Const PI_SET:Int
Const PI_LOW:Int
Const PI_HIGH:Int
Const PI_TIMEOUT:Int
Const PI_INPUT:Int
Const PI_OUTPUT:Int
Const PI_ALT0:Int
Const PI_ALT1:Int
Const PI_ALT2:Int
Const PI_ALT3:Int
Const PI_ALT4:Int
Const PI_ALT5:Int
Const PI_PUD_OFF:Int
Const PI_PUD_DOWN:Int
Const PI_PUD_UP:Int
Const PI_DEFAULT_DUTYCYCLE_RANGE:Int
Const PI_MIN_DUTYCYCLE_RANGE:Int
Const PI_MAX_DUTYCYCLE_RANGE:Int
Const PI_SERVO_OFF:Int
Const PI_MIN_SERVO_PULSEWIDTH:Int
Const PI_MAX_SERVO_PULSEWIDTH:Int
Const PI_HW_PWM_MIN_FREQ:Int
Const PI_HW_PWM_MAX_FREQ:Int
Const PI_HW_PWM_MAX_FREQ_2711:Int
Const PI_HW_PWM_RANGE:Int
Const PI_HW_CLK_MIN_FREQ:Int
Const PI_HW_CLK_MIN_FREQ_2711:Int
Const PI_HW_CLK_MAX_FREQ:Int
Const PI_HW_CLK_MAX_FREQ_2711:Int
Const PI_NOTIFY_SLOTS:Int
Const PI_NTFY_FLAGS_EVENT:Int
Const PI_NTFY_FLAGS_ALIVE:Int
Const PI_NTFY_FLAGS_WDOG:Int
Const PI_WAVE_BLOCKS:Int
Const PI_WAVE_MAX_PULSES:Int
Const PI_WAVE_MAX_CHARS:Int
Const PI_BB_I2C_MIN_BAUD:Int
Const PI_BB_I2C_MAX_BAUD:Int
Const PI_BB_SPI_MIN_BAUD:Int
Const PI_BB_SPI_MAX_BAUD:Int
Const PI_BB_SER_MIN_BAUD:Int
Const PI_BB_SER_MAX_BAUD:Int
Const PI_BB_SER_NORMAL:Int
Const PI_BB_SER_INVERT:Int
Const PI_WAVE_MIN_BAUD:Int
Const PI_WAVE_MAX_BAUD:Int
Const PI_SPI_MIN_BAUD:Int
Const PI_SPI_MAX_BAUD:Int
Const PI_MIN_WAVE_DATABITS:Int
Const PI_MAX_WAVE_DATABITS:Int
Const PI_MIN_WAVE_HALFSTOPBITS:Int
Const PI_MAX_WAVE_HALFSTOPBITS:Int
Const PI_WAVE_MAX_MICROS:Int
Const PI_MAX_WAVES:Int
Const PI_MAX_WAVE_CYCLES:Int
Const PI_MAX_WAVE_DELAY:Int
Const PI_WAVE_COUNT_PAGES:Int
Const PI_WAVE_MODE_ONE_SHOT:Int
Const PI_WAVE_MODE_REPEAT:Int
Const PI_WAVE_MODE_ONE_SHOT_SYNC:Int
Const PI_WAVE_MODE_REPEAT_SYNC:Int
Const PI_WAVE_NOT_FOUND:Int
Const PI_NO_TX_WAVE:Int
Const PI_FILE_SLOTS:Int
Const PI_I2C_SLOTS:Int
Const PI_SPI_SLOTS:Int
Const PI_SER_SLOTS:Int
Const PI_MAX_I2C_ADDR:Int
Const PI_NUM_AUX_SPI_CHANNEL:Int
Const PI_NUM_STD_SPI_CHANNEL:Int
Const PI_MAX_I2C_DEVICE_COUNT:Int
Const PI_MAX_SPI_DEVICE_COUNT:Int
Const PI_I2C_RDRW_IOCTL_MAX_MSGS:Int
Const PI_I2C_M_WR:Int
Const PI_I2C_M_RD:Int
Const PI_I2C_M_TEN:Int
Const PI_I2C_M_RECV_LEN:Int
Const PI_I2C_M_NO_RD_ACK:Int
Const PI_I2C_M_IGNORE_NAK:Int
Const PI_I2C_M_REV_DIR_ADDR:Int
Const PI_I2C_M_NOSTART:Int
Const PI_I2C_END:Int
Const PI_I2C_ESC:Int
Const PI_I2C_START:Int
Const PI_I2C_COMBINED_ON:Int
Const PI_I2C_STOP:Int
Const PI_I2C_COMBINED_OFF:Int
Const PI_I2C_ADDR:Int
Const PI_I2C_FLAGS:Int
Const PI_I2C_READ:Int
Const PI_I2C_WRITE:Int
Const BSC_DR:Int
Const BSC_RSR:Int
Const BSC_SLV:Int
Const BSC_CR:Int
Const BSC_FR:Int
Const BSC_IFLS:Int
Const BSC_IMSC:Int
Const BSC_RIS:Int
Const BSC_MIS:Int
Const BSC_ICR:Int
Const BSC_DMACR:Int
Const BSC_TDR:Int
Const BSC_GPUSTAT:Int
Const BSC_HCTRL:Int
Const BSC_DEBUG_I2C:Int
Const BSC_DEBUG_SPI:Int
Const BSC_CR_TESTFIFO:Int
Const BSC_CR_RXE:Int
Const BSC_CR_TXE:Int
Const BSC_CR_BRK:Int
Const BSC_CR_CPOL:Int
Const BSC_CR_CPHA:Int
Const BSC_CR_I2C:Int
Const BSC_CR_SPI:Int
Const BSC_CR_EN:Int
Const BSC_FR_RXBUSY:Int
Const BSC_FR_TXFE:Int
Const BSC_FR_RXFF:Int
Const BSC_FR_TXFF:Int
Const BSC_FR_RXFE:Int
Const BSC_FR_TXBUSY:Int
Const BSC_SDA_MOSI:Int
Const BSC_SCL_SCLK:Int
Const BSC_MISO:Int
Const BSC_CE_N:Int
Const BSC_SDA_MOSI_2711:Int
Const BSC_SCL_SCLK_2711:Int
Const BSC_MISO_2711:Int
Const BSC_CE_N_2711:Int
Const PI_MAX_BUSY_DELAY:Int
Const PI_MIN_WDOG_TIMEOUT:Int
Const PI_MAX_WDOG_TIMEOUT:Int
Const PI_MIN_TIMER:Int
Const PI_MAX_TIMER:Int
Const PI_MIN_MS:Int
Const PI_MAX_MS:Int
Const PI_MAX_SCRIPTS:Int
Const PI_MAX_SCRIPT_TAGS:Int
Const PI_MAX_SCRIPT_VARS:Int
Const PI_MAX_SCRIPT_PARAMS:Int
Const PI_SCRIPT_INITING:Int
Const PI_SCRIPT_HALTED:Int
Const PI_SCRIPT_RUNNING:Int
Const PI_SCRIPT_WAITING:Int
Const PI_SCRIPT_FAILED:Int
Const PI_MIN_SIGNUM:Int
Const PI_MAX_SIGNUM:Int
Const PI_TIME_RELATIVE:Int
Const PI_TIME_ABSOLUTE:Int
Const PI_MAX_MICS_DELAY:Int
Const PI_MAX_MILS_DELAY:Int
Const PI_BUF_MILLIS_MIN:Int
Const PI_BUF_MILLIS_MAX:Int
Const PI_CLOCK_PWM:Int
Const PI_CLOCK_PCM:Int
Const PI_MIN_DMA_CHANNEL:Int
Const PI_MAX_DMA_CHANNEL:Int
Const PI_MIN_SOCKET_PORT:Int
Const PI_MAX_SOCKET_PORT:Int
Const PI_DISABLE_FIFO_IF:Int
Const PI_DISABLE_SOCK_IF:Int
Const PI_LOCALHOST_SOCK_IF:Int
Const PI_DISABLE_ALERT:Int
Const PI_MEM_ALLOC_AUTO:Int
Const PI_MEM_ALLOC_PAGEMAP:Int
Const PI_MEM_ALLOC_MAILBOX:Int
Const PI_MAX_STEADY:Int
Const PI_MAX_ACTIVE:Int
Const PI_CFG_DBG_LEVEL:Int
Const PI_CFG_ALERT_FREQ:Int
Const PI_CFG_RT_PRIORITY:Int
Const PI_CFG_STATS:Int
Const PI_CFG_NOSIGHANDLER:Int
Const PI_CFG_ILLEGAL_VAL:Int
Const RISING_EDGE:Int
Const FALLING_EDGE:Int
Const EITHER_EDGE:Int
Const PI_MAX_PAD:Int
Const PI_MIN_PAD_STRENGTH:Int
Const PI_MAX_PAD_STRENGTH:Int
Const PI_FILE_NONE:Int
Const PI_FILE_MIN:Int
Const PI_FILE_READ:Int
Const PI_FILE_WRITE:Int
Const PI_FILE_RW:Int
Const PI_FILE_APPEND:Int
Const PI_FILE_CREATE:Int
Const PI_FILE_TRUNC:Int
Const PI_FILE_MAX:Int
Const PI_FROM_START:Int
Const PI_FROM_CURRENT:Int
Const PI_FROM_END:Int
Const MAX_CONNECT_ADDRESSES:Int
Const PI_MAX_EVENT:Int
Const PI_EVENT_BSC:Int
Const PI_CMD_MODES:Int
Const PI_CMD_MODEG:Int
Const PI_CMD_PUD:Int
Const PI_CMD_READ:Int
Const PI_CMD_WRITE:Int
Const PI_CMD_PWM:Int
Const PI_CMD_PRS:Int
Const PI_CMD_PFS:Int
Const PI_CMD_SERVO:Int
Const PI_CMD_WDOG:Int
Const PI_CMD_BR1:Int
Const PI_CMD_BR2:Int
Const PI_CMD_BC1:Int
Const PI_CMD_BC2:Int
Const PI_CMD_BS1:Int
Const PI_CMD_BS2:Int
Const PI_CMD_TICK:Int
Const PI_CMD_HWVER:Int
Const PI_CMD_NO:Int
Const PI_CMD_NB:Int
Const PI_CMD_NP:Int
Const PI_CMD_NC:Int
Const PI_CMD_PRG:Int
Const PI_CMD_PFG:Int
Const PI_CMD_PRRG:Int
Const PI_CMD_HELP:Int
Const PI_CMD_PIGPV:Int
Const PI_CMD_WVCLR:Int
Const PI_CMD_WVAG:Int
Const PI_CMD_WVAS:Int
Const PI_CMD_WVGO:Int
Const PI_CMD_WVGOR:Int
Const PI_CMD_WVBSY:Int
Const PI_CMD_WVHLT:Int
Const PI_CMD_WVSM:Int
Const PI_CMD_WVSP:Int
Const PI_CMD_WVSC:Int
Const PI_CMD_TRIG:Int
Const PI_CMD_PROC:Int
Const PI_CMD_PROCD:Int
Const PI_CMD_PROCR:Int
Const PI_CMD_PROCS:Int
Const PI_CMD_SLRO:Int
Const PI_CMD_SLR:Int
Const PI_CMD_SLRC:Int
Const PI_CMD_PROCP:Int
Const PI_CMD_MICS:Int
Const PI_CMD_MILS:Int
Const PI_CMD_PARSE:Int
Const PI_CMD_WVCRE:Int
Const PI_CMD_WVDEL:Int
Const PI_CMD_WVTX:Int
Const PI_CMD_WVTXR:Int
Const PI_CMD_WVNEW:Int
Const PI_CMD_I2CO:Int
Const PI_CMD_I2CC:Int
Const PI_CMD_I2CRD:Int
Const PI_CMD_I2CWD:Int
Const PI_CMD_I2CWQ:Int
Const PI_CMD_I2CRS:Int
Const PI_CMD_I2CWS:Int
Const PI_CMD_I2CRB:Int
Const PI_CMD_I2CWB:Int
Const PI_CMD_I2CRW:Int
Const PI_CMD_I2CWW:Int
Const PI_CMD_I2CRK:Int
Const PI_CMD_I2CWK:Int
Const PI_CMD_I2CRI:Int
Const PI_CMD_I2CWI:Int
Const PI_CMD_I2CPC:Int
Const PI_CMD_I2CPK:Int
Const PI_CMD_SPIO:Int
Const PI_CMD_SPIC:Int
Const PI_CMD_SPIR:Int
Const PI_CMD_SPIW:Int
Const PI_CMD_SPIX:Int
Const PI_CMD_SERO:Int
Const PI_CMD_SERC:Int
Const PI_CMD_SERRB:Int
Const PI_CMD_SERWB:Int
Const PI_CMD_SERR:Int
Const PI_CMD_SERW:Int
Const PI_CMD_SERDA:Int
Const PI_CMD_GDC:Int
Const PI_CMD_GPW:Int
Const PI_CMD_HC:Int
Const PI_CMD_HP:Int
Const PI_CMD_CF1:Int
Const PI_CMD_CF2:Int
Const PI_CMD_BI2CC:Int
Const PI_CMD_BI2CO:Int
Const PI_CMD_BI2CZ:Int
Const PI_CMD_I2CZ:Int
Const PI_CMD_WVCHA:Int
Const PI_CMD_SLRI:Int
Const PI_CMD_CGI:Int
Const PI_CMD_CSI:Int
Const PI_CMD_FG:Int
Const PI_CMD_FN:Int
Const PI_CMD_NOIB:Int
Const PI_CMD_WVTXM:Int
Const PI_CMD_WVTAT:Int
Const PI_CMD_PADS:Int
Const PI_CMD_PADG:Int
Const PI_CMD_FO:Int
Const PI_CMD_FC:Int
Const PI_CMD_FR:Int
Const PI_CMD_FW:Int
Const PI_CMD_FS:Int
Const PI_CMD_FL:Int
Const PI_CMD_SHELL:Int
Const PI_CMD_BSPIC:Int
Const PI_CMD_BSPIO:Int
Const PI_CMD_BSPIX:Int
Const PI_CMD_BSCX:Int
Const PI_CMD_EVM:Int
Const PI_CMD_EVT:Int
Const PI_CMD_PROCU:Int
Const PI_CMD_WVCAP:Int
Const PI_CMD_SCRIPT:Int
Const PI_CMD_ADD:Int
Const PI_CMD_AND:Int
Const PI_CMD_CALL:Int
Const PI_CMD_CMDR:Int
Const PI_CMD_CMDW:Int
Const PI_CMD_CMP:Int
Const PI_CMD_DCR:Int
Const PI_CMD_DCRA:Int
Const PI_CMD_DIV:Int
Const PI_CMD_HALT:Int
Const PI_CMD_INR:Int
Const PI_CMD_INRA:Int
Const PI_CMD_JM:Int
Const PI_CMD_JMP:Int
Const PI_CMD_JNZ:Int
Const PI_CMD_JP:Int
Const PI_CMD_JZ:Int
Const PI_CMD_TAG:Int
Const PI_CMD_LD:Int
Const PI_CMD_LDA:Int
Const PI_CMD_LDAB:Int
Const PI_CMD_MLT:Int
Const PI_CMD_MOD:Int
Const PI_CMD_NOP:Int
Const PI_CMD_OR:Int
Const PI_CMD_POP:Int
Const PI_CMD_POPA:Int
Const PI_CMD_PUSH:Int
Const PI_CMD_PUSHA:Int
Const PI_CMD_RET:Int
Const PI_CMD_RL:Int
Const PI_CMD_RLA:Int
Const PI_CMD_RR:Int
Const PI_CMD_RRA:Int
Const PI_CMD_STA:Int
Const PI_CMD_STAB:Int
Const PI_CMD_SUB:Int
Const PI_CMD_SYS:Int
Const PI_CMD_WAIT:Int
Const PI_CMD_X:Int
Const PI_CMD_XA:Int
Const PI_CMD_XOR:Int
Const PI_CMD_EVTWT:Int
Const PI_INIT_FAILED:Int
Const PI_BAD_USER_GPIO:Int
Const PI_BAD_GPIO:Int
Const PI_BAD_MODE:Int
Const PI_BAD_LEVEL:Int
Const PI_BAD_PUD:Int
Const PI_BAD_PULSEWIDTH:Int
Const PI_BAD_DUTYCYCLE:Int
Const PI_BAD_TIMER:Int
Const PI_BAD_MS:Int
Const PI_BAD_TIMETYPE:Int
Const PI_BAD_SECONDS:Int
Const PI_BAD_MICROS:Int
Const PI_TIMER_FAILED:Int
Const PI_BAD_WDOG_TIMEOUT:Int
Const PI_NO_ALERT_FUNC:Int
Const PI_BAD_CLK_PERIPH:Int
Const PI_BAD_CLK_SOURCE:Int
Const PI_BAD_CLK_MICROS:Int
Const PI_BAD_BUF_MILLIS:Int
Const PI_BAD_DUTYRANGE:Int
Const PI_BAD_DUTY_RANGE:Int
Const PI_BAD_SIGNUM:Int
Const PI_BAD_PATHNAME:Int
Const PI_NO_HANDLE:Int
Const PI_BAD_HANDLE:Int
Const PI_BAD_IF_FLAGS:Int
Const PI_BAD_CHANNEL:Int
Const PI_BAD_PRIM_CHANNEL:Int
Const PI_BAD_SOCKET_PORT:Int
Const PI_BAD_FIFO_COMMAND:Int
Const PI_BAD_SECO_CHANNEL:Int
Const PI_NOT_INITIALISED:Int
Const PI_INITIALISED:Int
Const PI_BAD_WAVE_MODE:Int
Const PI_BAD_CFG_INTERNAL:Int
Const PI_BAD_WAVE_BAUD:Int
Const PI_TOO_MANY_PULSES:Int
Const PI_TOO_MANY_CHARS:Int
Const PI_NOT_SERIAL_GPIO:Int
Const PI_BAD_SERIAL_STRUC:Int
Const PI_BAD_SERIAL_BUF:Int
Const PI_NOT_PERMITTED:Int
Const PI_SOME_PERMITTED:Int
Const PI_BAD_WVSC_COMMND:Int
Const PI_BAD_WVSM_COMMND:Int
Const PI_BAD_WVSP_COMMND:Int
Const PI_BAD_PULSELEN:Int
Const PI_BAD_SCRIPT:Int
Const PI_BAD_SCRIPT_ID:Int
Const PI_BAD_SER_OFFSET:Int
Const PI_GPIO_IN_USE:Int
Const PI_BAD_SERIAL_COUNT:Int
Const PI_BAD_PARAM_NUM:Int
Const PI_DUP_TAG:Int
Const PI_TOO_MANY_TAGS:Int
Const PI_BAD_SCRIPT_CMD:Int
Const PI_BAD_VAR_NUM:Int
Const PI_NO_SCRIPT_ROOM:Int
Const PI_NO_MEMORY:Int
Const PI_SOCK_READ_FAILED:Int
Const PI_SOCK_WRIT_FAILED:Int
Const PI_TOO_MANY_PARAM:Int
Const PI_NOT_HALTED:Int
Const PI_SCRIPT_NOT_READY:Int
Const PI_BAD_TAG:Int
Const PI_BAD_MICS_DELAY:Int
Const PI_BAD_MILS_DELAY:Int
Const PI_BAD_WAVE_ID:Int
Const PI_TOO_MANY_CBS:Int
Const PI_TOO_MANY_OOL:Int
Const PI_EMPTY_WAVEFORM:Int
Const PI_NO_WAVEFORM_ID:Int
Const PI_I2C_OPEN_FAILED:Int
Const PI_SER_OPEN_FAILED:Int
Const PI_SPI_OPEN_FAILED:Int
Const PI_BAD_I2C_BUS:Int
Const PI_BAD_I2C_ADDR:Int
Const PI_BAD_SPI_CHANNEL:Int
Const PI_BAD_FLAGS:Int
Const PI_BAD_SPI_SPEED:Int
Const PI_BAD_SER_DEVICE:Int
Const PI_BAD_SER_SPEED:Int
Const PI_BAD_PARAM:Int
Const PI_I2C_WRITE_FAILED:Int
Const PI_I2C_READ_FAILED:Int
Const PI_BAD_SPI_COUNT:Int
Const PI_SER_WRITE_FAILED:Int
Const PI_SER_READ_FAILED:Int
Const PI_SER_READ_NO_DATA:Int
Const PI_UNKNOWN_COMMAND:Int
Const PI_SPI_XFER_FAILED:Int
Const PI_BAD_POINTER:Int
Const PI_NO_AUX_SPI:Int
Const PI_NOT_PWM_GPIO:Int
Const PI_NOT_SERVO_GPIO:Int
Const PI_NOT_HCLK_GPIO:Int
Const PI_NOT_HPWM_GPIO:Int
Const PI_BAD_HPWM_FREQ:Int
Const PI_BAD_HPWM_DUTY:Int
Const PI_BAD_HCLK_FREQ:Int
Const PI_BAD_HCLK_PASS:Int
Const PI_HPWM_ILLEGAL:Int
Const PI_BAD_DATABITS:Int
Const PI_BAD_STOPBITS:Int
Const PI_MSG_TOOBIG:Int
Const PI_BAD_MALLOC_MODE:Int
Const PI_TOO_MANY_SEGS:Int
Const PI_BAD_I2C_SEG:Int
Const PI_BAD_SMBUS_CMD:Int
Const PI_NOT_I2C_GPIO:Int
Const PI_BAD_I2C_WLEN:Int
Const PI_BAD_I2C_RLEN:Int
Const PI_BAD_I2C_CMD:Int
Const PI_BAD_I2C_BAUD:Int
Const PI_CHAIN_LOOP_CNT:Int
Const PI_BAD_CHAIN_LOOP:Int
Const PI_CHAIN_COUNTER:Int
Const PI_BAD_CHAIN_CMD:Int
Const PI_BAD_CHAIN_DELAY:Int
Const PI_CHAIN_NESTING:Int
Const PI_CHAIN_TOO_BIG:Int
Const PI_DEPRECATED:Int
Const PI_BAD_SER_INVERT:Int
Const PI_BAD_EDGE:Int
Const PI_BAD_ISR_INIT:Int
Const PI_BAD_FOREVER:Int
Const PI_BAD_FILTER:Int
Const PI_BAD_PAD:Int
Const PI_BAD_STRENGTH:Int
Const PI_FIL_OPEN_FAILED:Int
Const PI_BAD_FILE_MODE:Int
Const PI_BAD_FILE_FLAG:Int
Const PI_BAD_FILE_READ:Int
Const PI_BAD_FILE_WRITE:Int
Const PI_FILE_NOT_ROPEN:Int
Const PI_FILE_NOT_WOPEN:Int
Const PI_BAD_FILE_SEEK:Int
Const PI_NO_FILE_MATCH:Int
Const PI_NO_FILE_ACCESS:Int
Const PI_FILE_IS_A_DIR:Int
Const PI_BAD_SHELL_STATUS:Int
Const PI_BAD_SCRIPT_NAME:Int
Const PI_BAD_SPI_BAUD:Int
Const PI_NOT_SPI_GPIO:Int
Const PI_BAD_EVENT_ID:Int
Const PI_CMD_INTERRUPTED:Int
Const PI_NOT_ON_BCM2711:Int
Const PI_ONLY_ON_BCM2711:Int
Const PI_PIGIF_ERR_0:Int
Const PI_PIGIF_ERR_99:Int
Const PI_CUSTOM_ERR_0:Int
Const PI_CUSTOM_ERR_999:Int
Const PI_DEFAULT_BUFFER_MILLIS:Int
Const PI_DEFAULT_CLK_MICROS:Int
Const PI_DEFAULT_CLK_PERIPHERAL:Int
Const PI_DEFAULT_IF_FLAGS:Int
Const PI_DEFAULT_FOREGROUND:Int
Const PI_DEFAULT_DMA_CHANNEL:Int
Const PI_DEFAULT_DMA_PRIMARY_CHANNEL:Int
Const PI_DEFAULT_DMA_SECONDARY_CHANNEL:Int
Const PI_DEFAULT_DMA_PRIMARY_CH_2711:Int
Const PI_DEFAULT_DMA_SECONDARY_CH_2711:Int
Const PI_DEFAULT_DMA_NOT_SET:Int
Const PI_DEFAULT_SOCKET_PORT:Int
Const PI_DEFAULT_SOCKET_PORT_STR:CString ' "8888"
Const PI_DEFAULT_SOCKET_ADDR_STR:CString ' "localhost"
Const PI_DEFAULT_UPDATE_MASK_UNKNOWN:Int
Const PI_DEFAULT_UPDATE_MASK_B1:Int
Const PI_DEFAULT_UPDATE_MASK_A_B2:Int
Const PI_DEFAULT_UPDATE_MASK_APLUS_BPLUS:Int
Const PI_DEFAULT_UPDATE_MASK_ZERO:Int
Const PI_DEFAULT_UPDATE_MASK_PI2B:Int
Const PI_DEFAULT_UPDATE_MASK_PI3B:Int
Const PI_DEFAULT_UPDATE_MASK_PI4B:Int
Const PI_DEFAULT_UPDATE_MASK_COMPUTE:Int
Const PI_DEFAULT_MEM_ALLOC_MODE:Int
Const PI_DEFAULT_CFG_INTERNALS:Int
