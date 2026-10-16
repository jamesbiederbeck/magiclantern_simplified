/** \file
 * Entry points into the firmware image.
 *
 * These are the functions that we can call from our tasks
 * in the Canon 1.2.1 firmware for the 2000D / Rebel T7 / Kiss X90.
 *
 * WORK IN PROGRESS: only stubs marked "2000D:" are verified; lines marked
 * "1300D, unchecked" are the 1300D 1.1.0 addresses kept as a to-do list.
 *
 */
/*
 * Copyright (C) 2017 Magic Lantern Team
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the
 * Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor,
 * Boston, MA  02110-1301, USA.
 */

#include <stub.h>

.text

// for task information

/** Startup **/
NSTUB(MAIN_FIRMWARE_ADDR, firmware_entry)
NSTUB(0xFE0C3A38,  cstart)                                  // 2000D: b from firmware_entry+0x638 (HIJACK_INSTR_BL_CSTART)
NSTUB(   0x29898,  bzero32)                                 // 2000D: called by cstart(); 32-byte zero loop
NSTUB(    0x5254,  create_init_task)                        // 2000D: called by cstart() with init_task
NSTUB(0xFE12A098,  init_task)                               // 2000D: cstart literal at FE0C3B34; gdb: breakpoint hit
// 1300D, unchecked: NSTUB(   0x67430,  additional_version)

/** File I/O **/
NSTUB(0xfe2a3f48,  FIO_CloseFile)                           // 2000D: bracket -0x4B4
NSTUB(0xfe2a4f1c,  FIO_FindClose)                           // 2000D: probe: same handle
NSTUB(0xfe2a4e3c,  FIO_FindNextEx)                          // 2000D: probe: handle from FindFirstEx
NSTUB(0xfe2a3cf8,  _FIO_ReadFile)                           // 2000D: bracket -0x4B4
NSTUB(0xfe2a3da8,  FIO_SeekSkipFile)                        // 2000D: bracket -0x4B4
NSTUB(0xfe2a3e98,  _FIO_WriteFile)                          // 2000D: bracket -0x4B4
NSTUB(0xfe2a4788,  _FIO_CreateDirectory)                    // 2000D: bracket -0x4B4
NSTUB(0xfe2a3ba4,  _FIO_CreateFile)                         // 2000D: bracket -0x4B4
NSTUB(0xfe2a4d48,  _FIO_FindFirstEx)                        // 2000D: probe: r0 = "B:/DCIM"
NSTUB(0xfe2a40c4,  _FIO_GetFileSize)                        // 2000D: probe: r0 = "B:/comstate.to2"
NSTUB(0xfe2a3ae8,  _FIO_OpenFile)                           // 2000D: bracket -0x4B4
NSTUB(0xfe2a3c50,  _FIO_RemoveFile)                         // 2000D: bracket -0x4B4
NSTUB(0xfe2a45c0,  _FIO_RenameFile)                         // 2000D: bracket -0x4B4

/** GUI **/
NSTUB(0x0003136c,  gui_main_struct)                         // 2000D: loaded by gui_main_task
NSTUB(0x0003d914,  gui_task_list)                           // 2000D: runtime: lock, current(+8) -> gui_task -> date dialog; used by FE3EF330 (1300D addr is WRONG here)
NSTUB(0xfe0cca74,  GUI_ChangeMode)                          // 2000D: probe: modes 0/1 from PropMgr
NSTUB(0xfe0cc8b8,  GUI_Control)                             // 2000D: probe: event codes 0x34, 0x54, ...
NSTUB(0xfe14df34,  SetGUIRequestMode)                       // 2000D: probe: modes 2/3; only user of "SetGUIRequestMode" string
NSTUB(0xfe0ccf28,  gui_init_end)                            // 2000D: first call in gui_main_task
NSTUB(0xfe0cc4e8,  gui_main_task)                           // 2000D: entry of task GuiMainTask; loads gui_main_struct, msg at +0x30
// 1300D, unchecked: NSTUB(0xFE151800,  gui_massive_event_loop)                  // GUI_Control_Post   [2000D candidate 0xfe1537b4: called at boot, args inconclusive]
// 1300D, unchecked: NSTUB(0xFE2EB7F8,  GUI_SetLvMode)                           /* present on 500D.111, 50D.109, 5D2.212 */
// NSTUB(    ???,  GUI_SetMovieSize_a)                      /* present on 50D.109 */
// NSTUB(    ???,  GUI_SetMovieSize_b)                      /* present on 50D.109 */
// 1300D, unchecked: NSTUB(0xFE2EBA2C,  Gui_SetSoundRecord)                   /* present on 6D.113, 5D2.212 */   [2000D candidate 0xfe2eb99c: cluster shift -0x90 (2/3 aligned, runner-up 2), not exercised]

/** ASIF **/
// TODO:
// 1300D, unchecked: NSTUB(0xfe11d1cc,  PowerAudioOutput)                       /* not found  old FE108E44*/   [2000D candidate 0xfe11db80: cluster shift +0x9b4 (5/5 aligned, runner-up 3), not exercised]
// 1300D, unchecked: NSTUB(0xFE11B938,  SetAudioVolumeOut)   [2000D candidate 0xfe11c2ec: cluster shift +0x9b4 (5/5 aligned, runner-up 3), not exercised]
// 1300D, unchecked: NSTUB(0xFE106A98,  SetNextASIFADCBuffer)   [2000D candidate 0xfe106ac8: cluster shift +0x30 (6/7 aligned, runner-up 3), not exercised]
// 1300D, unchecked: NSTUB(0xFE106C80,  SetNextASIFDACBuffer)   [2000D candidate 0xfe106cb0: cluster shift +0x30 (6/7 aligned, runner-up 3), not exercised]
// 1300D, unchecked: NSTUB(0xFE11C690,  SetSamplingRate)   [2000D candidate 0xfe11d044: cluster shift +0x9b4 (5/5 aligned, runner-up 3), not exercised]
// 1300D, unchecked: NSTUB(0xFE105F7C,  StartASIFDMAADC)   [2000D candidate 0xfe105fac: cluster shift +0x30 (6/7 aligned, runner-up 3), not exercised]
// 1300D, unchecked: NSTUB(0xFE106350,  StartASIFDMADAC)   [2000D candidate 0xfe106380: cluster shift +0x30 (6/7 aligned, runner-up 3), not exercised]
// 1300D, unchecked: NSTUB(0xFE1065D0,  StopASIFDMADAC)
// 1300D, unchecked: NSTUB(0xFE11CD04,  PowerMicAmp)                           /* present on 650D.104, EOSM.202, 700D.113 */   [2000D candidate 0xfe11d6b8: cluster shift +0x9b4 (5/5 aligned, runner-up 3), not exercised]
// 1300D, unchecked: NSTUB(0xFE1066F8,  SetASIFMode)                             /* present on 700D.113 */   [2000D candidate 0xfe106728: cluster shift +0x30 (6/7 aligned, runner-up 3), not exercised]
//NSTUB(0xFE108E10,  SetAudioVolumeIn) //?                       /* present on 6D.113 */
// 1300D, unchecked: NSTUB(0xFE108A70,  SoundDevActiveIn) //ok                       /* present on 7D.203, 6D.113, 650D.104, EOSM.202, 700D.113 */   [2000D candidate 0xfe108aa0: cluster shift +0x30 (3/4 aligned, runner-up 3), not exercised]
// 1300D, unchecked: NSTUB(0xFE108CC8,  SoundDevShutDownIn)//ok                      /* present on 7D.203, 6D.113, 650D.104, EOSM.202, 700D.113 */
// 1300D, unchecked: NSTUB(0xFE106228,  StopASIFDMAADC) //ok                          /* present on 7D.203, 6D.113, EOSM.202 */   [2000D candidate 0xfe106258: cluster shift +0x30 (6/7 aligned, runner-up 3), not exercised]


/** Audio **/
// 1300D, unchecked: NSTUB(    0x31604,  sounddev)                               // in sounddev_task
// TODO: Not found direct write it looks like its some kind of serial connection now
// 1300D, unchecked: NSTUB(0xFE2B3A3C, _audio_ic_read) // FE2B3A3C   [2000D candidate 0xfe2b3a5c: cluster shift +0x20 (2/2 aligned, runner-up 2), not exercised]
// 1300D, unchecked: NSTUB(0xFE2B36D4, _audio_ic_write) // posible sub_FE2B3A18   [2000D candidate 0xfe2b36f4: called at boot, args inconclusive]
NSTUB(0xfe8e3814,  audio_thresholds)                        // 2000D: ref: exact 0x7fff,0x7213,0x65ab,... sequence
// 1300D, unchecked: NSTUB(0xFE108A70,  sounddev_active_in)                      // "SoundDevActiveIn"   [2000D candidate 0xfe108aa0: cluster shift +0x30 (3/4 aligned, runner-up 3), not exercised]
NSTUB(0xfe108690,  sounddev_task)                           // 2000D: entry of task "SoundDevice"
// NSTUB(    ???, _audio_ic_write_bulk)                     /* present on 6D.116 */

/** Bitmap **/
NSTUB(   0x536A0,  LCD_Palette)                             // 2000D: InitializeBitmapDisplayDevice, right after 0xc0f14800; = bmp_vram_info - 0x1800 as on 1300D
NSTUB(   0x54EA0,  bmp_vram_info)                           // 2000D: SetBitmapVramAddress (FE113BBC) table; [1].vram2 = 0x02007100 at runtime

/** CFN **/
// 1300D, unchecked: NSTUB(0xFE71C2A4,  GetCFnData)   [2000D candidate 0xfe71b310: cluster shift -0xf94 (1/2 aligned, runner-up 1), not exercised]
// 1300D, unchecked: NSTUB(0xFE71C4D0,  SetCFnData)
// NSTUB(    ???,  GUI_GetCFnForTab4)                       /* present on 7D.203 */
// NSTUB(0xFE4716F0,  GUI_SetCFnForTab4)                    /* present on 7D.203 */

/** Camera interface? **/
// TODO:
// 1300D, unchecked: NSTUB(0xC0220000,  camera_engine)

/** MPU communication **/
// 1300D, unchecked: NSTUB(0xFE2993B4, _mpu_send);                               /* dwSize < TXBD_DATA_SIZE */   [2000D candidate 0xfe298868: called at boot, args inconclusive]
// 1300D, unchecked: NSTUB(0xFE10FA70, _mpu_recv);                               /* registered in InitializeIntercom as CBR */   [2000D candidate 0xfe10eb78: cluster shift -0xef8 (1/1 aligned, runner-up 1), not exercised]

/** DMA **/
// 1300D, unchecked: NSTUB(0xFE1244E0,  dma_memcpy)   [2000D: shift guess 0xfe124e94 WRONG: called from IRQ handler with junk args]

/** Debug messages **/
NSTUB(0x00031bf8,  dm_names)                                // 2000D: runtime: [1]="[PRP] ", [2]="[PROPAD] " (1300D had 0x31BF4)
NSTUB(0xfe11fd48,  DryosDebugMsg)                           // 2000D: 24687 call sites, r2 = fmt; qemu debugmsg plugin prints Canon log
NSTUB(0xfe1200b0,  dm_set_store_level)                      // 2000D: tail call from "dmstore" eventproc; probe (0xff, 3)
NSTUB(0xfe120048,  dm_set_print_level)                      // 2000D: tail call from "dmprint" eventproc

/** Dialog API **/
NSTUB(0xfe3f10cc,  dialog_redraw)                           // 2000D: probe: dialog objects of several screens
NSTUB(0xfe2f8e14,  dialog_set_property_str)                 // 2000D: probe: (date dialog, id, "yy/mm/dd" / "Los Angeles")

/** Dialog handlers **/
// 1300D, unchecked: NSTUB(0xFE5AC378,  ErrCardForLVApp_handler)                 // LiveViewErrorApp, as in 60D   [2000D candidate 0xfe5ab3b8: cluster shift -0xfc0 (1/1 aligned, runner-up 1), not exercised]
NSTUB(0xfe4561dc,  ErrForCamera_handler)                    // 2000D PROBABLE: function referencing "ErrForCamera", +0xAA0
// 1300D, unchecked: NSTUB(0xFE488590,  HideUnaviFeedBack_maybe)                 // look for StartUnaviFeedBackTimer   [2000D candidate 0xfe4875d8: cluster shift -0xfb8 (1/1 aligned, runner-up 1), not exercised]
NSTUB(0xfe48dc04,  LiveViewApp_handler)                     // 2000D: runtime: top dialog handler in LiveView
NSTUB(0xfe48e270,  LiveViewApp_handler_BL_JudgeBottomInfoDispTimerState)// 2000D: struct: bl to the fn logging "JudgeBottomInfoDispTimerState"
NSTUB(0xfe48f8ac,  LiveViewApp_handler_end)                 // 2000D: same +0xABC shift as handler, next function start
NSTUB(0x00000000,  PlayMain_handler)                        // 2000D PLACEHOLDER: not found yet ("No image" playback uses another dialog); 0 = never matches
NSTUB(0x00000000,  PlayMovieGuideApp_handler)               // 2000D PLACEHOLDER: not found yet; 0 = never matches
NSTUB(0xfe49cdbc,  ShootOlcApp_handler)                     // 2000D: runtime: top dialog handler on shooting screen
// NSTUB(    ???,  LiveViewLevelApp_handler)                /* present on 5D3.113 */
// NSTUB(    ???,  LiveViewShutterApp_handler)              /* present on 6D.113, 650D.104, EOSM.202, 700D.113 */
// NSTUB(0xFE49AA14,  LiveViewWbApp_handler)                /* present on 7D.203, 5D3.113, 5D2.212 */
// NSTUB(    ???,  LiveViewWifiApp_handler)                 /* present on 6D.113 */
// NSTUB(    ???,  StartPlayProtectGuideApp)                /* present on 7D.203, 5D2.212 */
// NSTUB(    ???,  StopPlayProtectGuideApp)                 /* present on 7D.203, 5D2.212 */

/** Display **/
// 1300D, unchecked: NSTUB(0xFE40E9E4,  MirrorDisplay)   [2000D candidate 0xfe40f06c: cluster shift +0x688 (3/3 aligned, runner-up 2), not exercised]
// 1300D, unchecked: NSTUB(0xFE40EA44,  NormalDisplay)   [2000D candidate 0xfe40f0cc: cluster shift +0x688 (3/3 aligned, runner-up 2), not exercised]
// 1300D, unchecked: NSTUB(0xFE40EA14,  ReverseDisplay)   [2000D candidate 0xfe40f09c: cluster shift +0x688 (3/3 aligned, runner-up 2), not exercised]

/** EDMAC **/
NSTUB(0xfe29e3f4,  AbortEDmac)                              // 2000D: bracket -0x4B4
NSTUB(0xfe29e100,  ConnectReadEDmac)                        // 2000D: probe: (ch 0xd, 6)
NSTUB(0xfe29e03c,  ConnectWriteEDmac)                       // 2000D: probe: (ch 0x12, 6)
NSTUB(0xfe29e4bc,  RegisterEDmacAbortCBR)                   // 2000D: probe: (ch, cbr)
NSTUB(0xfe29e494,  RegisterEDmacCompleteCBR)                // 2000D: probe: (ch, cbr)
NSTUB(0xfe29e5c0,  RegisterEDmacPopCBR)                     // 2000D: probe: (ch, cbr)
NSTUB(0xfe29df84,  SetEDmac)                                // 2000D: probe: (ch 0xd, 0x40d07800, info)
NSTUB(0xfe29e2a0,  StartEDmac)                              // 2000D: probe: (ch 0x12 / 0xd)
NSTUB(0xfe29e4fc,  UnregisterEDmacAbortCBR)                 // 2000D: probe: (ch)
NSTUB(0xfe29e4a8,  UnregisterEDmacCompleteCBR)              // 2000D: probe: (ch)
NSTUB(0xfe29e5d4,  UnregisterEDmacPopCBR)                   // 2000D: probe: (ch)

/** Electronic Level **/
// 1300D, unchecked: NSTUB(0xFE2EB038,  GUI_SetRollingPitchingLevelStatus)   [2000D candidate 0xfe2eafa8: cluster shift -0x90 (2/3 aligned, runner-up 2), not exercised]

/** Engio **/
NSTUB(0xfe29f390,  _EngDrvOut)                              // 2000D: probe: (0xc0f01000, value)
NSTUB(0xfe29f73c,  _engio_write)                            // 2000D: probe: r0 = reg/value list
//NSTUB(0xFE29FC98,  shamem_read) //0xfe29f838
NSTUB(0xfe29f280,  shamem_read)                             // 2000D: probe: r0 = 0xc0f05038

/** Eventprocs (call by name) **/
NSTUB(0xfe120c3c,  call)                                    // 2000D: probe: r0 = "InitializePTPFrameworkController"

/** Events **/
NSTUB(0xfe2c232c,  TryPostEvent)                            // 2000D: probe: (handler, obj, event, arg)
// 1300D, unchecked: NSTUB(0xFE2C2364,  TryPostEvent_end)                        /* present on 6D.113, 650D.104, EOSM.202, 700D.113 */   [2000D candidate 0xfe2c1cb0: called at boot, args inconclusive]
NSTUB(0xfe2be754,  TryPostStageEvent)                       // 2000D: probe
// 1300D, unchecked: NSTUB(0xFE2BE78C,  TryPostStageEvent_end)                   /* present on 6D.113, 650D.104, EOSM.202, 700D.113 */   [2000D candidate 0xfe2c0270: cluster shift +0x1ae4 (2/2 aligned, runner-up 2), not exercised]

/** ExMem **/
NSTUB(0xfe123638,  AddMemoryChunk)                          // 2000D: bracket +0x9B4
NSTUB(0xfe125ae8,  AllocateContinuousMemoryResource)        // 2000D: ref: only user of "m_pfContAllocMemoryCBR"
NSTUB(0xfe125a9c,  AllocateMemoryResource)                  // 2000D: ref: only user of "m_pfAllocMemoryCBR" assert
NSTUB(0xfe122bb4,  CreateMemoryChunk)                       // 2000D: probe: same args, called by CreateMemorySuite
NSTUB(0xfe123398,  CreateMemorySuite)                       // 2000D: probe: (0x40a24580, 0x25800, 0)
NSTUB(0xfe1231cc,  DeleteMemorySuite)                       // 2000D: probe: suite 0xc3e58
NSTUB(0xfe125c00,  FreeMemoryResource)                      // 2000D: ref: only user of "m_pfFreeMemoryCBR"
NSTUB(0xfe123708,  GetFirstChunkFromSuite)                  // 2000D: probe: suite 0xc3e58
NSTUB(0xfe123158,  GetMemoryAddressOfMemoryChunk)           // 2000D: bracket +0x9B4
NSTUB(0xfe123e94,  GetNextMemoryChunk)                      // 2000D: probe: (suite 0xc3e58, chunk 0xc3e80)
NSTUB(0xfe0d54fc,  SRM_AllocateMemoryResourceFor1stJob)     // 2000D: struct: call + take_semaphore + "...1stJob failed" message
NSTUB(0xfe0d7d70,  SRM_FreeMemoryResourceFor1stJob)         // 2000D PROBABLE: (buf,0,0) callee only from the 1stJob module

/** GUI for old cameras **/
// 1300D, unchecked: NSTUB(   0x36CAC,  gui_timer_struct)                        // in GUI_Control_Post
// 1300D, unchecked: NSTUB(0xFE1536A0,  gui_change_mode)                         // GUI_ChangeMode_Post
// 1300D, unchecked: NSTUB(0xFE153E80,  gui_local_post)
// 1300D, unchecked: NSTUB(0xFE1544A8,  gui_other_post)
// NSTUB(    ???,  gui_change_lcd_state_post)               /* present on 7D.203, 500D.111, 50D.109, 5D2.212 */

// 1300D, unchecked: NSTUB(0xFE154890,  gui_change_shoot_type_post)              /* present on 7D.203, 500D.111, 50D.109, 5D2.212 */   [2000D candidate 0xfe153900: called at boot, args inconclusive]
// 1300D, unchecked: NSTUB(0xFE15511C,  gui_init_event)                          /* present on 7D.203, 500D.111, 50D.109, 5D2.212 */   [2000D candidate 0xfe15418c: called at boot, args inconclusive]
//NSTUB(0xFE154808,  gui_post_10000085)                       /* present on 500D.111, 50D.109, 5D2.212 */
// NSTUB(    ???,  gui_timer_something)                     /* present on 7D.203, 500D.111, 50D.109, 5D2.212 */

/** GUI timers **/
NSTUB(0xfe483a9c,  CancelDateTimer)                         // 2000D PROBABLE: +0xABC region shift, function start; not exercised
NSTUB(0xfe129a48,  CancelTimer)                             // 2000D: probe: r0 = timer id
NSTUB(0xfe1216a0,  SetHPTimerAfterNow)                      // 2000D: probe: (1000 us, cbr, cbr, arg)
NSTUB(0xfe121790,  SetHPTimerNextTick)                      // 2000D: bracket +0x9B4
NSTUB(0xfe129978,  SetTimerAfter)                           // 2000D: probe: (delay, cbr, cbr, arg)

/** H264 Encoder **/
// 1300D, unchecked: NSTUB(   0x38AC8,  mvr_config)
// 1300D, unchecked: NSTUB(0xFE281D2C,  mvrFixQScale)   [2000D candidate 0xfe281834: cluster shift -0x4f8 (3/4 aligned, runner-up 2), not exercised]
// 1300D, unchecked: NSTUB(0xFE2817F0,  mvrSetDefQScale)   [2000D candidate 0xfe2812f8: cluster shift -0x4f8 (3/4 aligned, runner-up 2), not exercised]
// 1300D, unchecked: NSTUB(0xFE281838,  mvrSetFullHDOptSize)
// 1300D, unchecked: NSTUB(0xFE281A1C,  mvrSetGopOptSizeFULLHD)   [2000D candidate 0xfe281524: cluster shift -0x4f8 (3/4 aligned, runner-up 2), not exercised]

/** Interrupts **/
// NSTUB(    ???,  isr_table_handler)                       /* present on 7D_MASTER.203 */
// NSTUB(    ???,  isr_table_param)                         /* present on 7D_MASTER.203 */
// 1300D, unchecked: NSTUB(   0x310a4,  post_isr_hook)                           /* present on 7D.203, 6D.113, 5D3.113, EOSM.202 */
NSTUB(   0x310a0,  pre_isr_hook)                            // 2000D: IRQ handler (RAM 0x50C) calls through it

/** LCD Sensor **/
// 1300D, unchecked: NSTUB(0xFE12BBC8,  DispSensorStart)   [2000D candidate 0xfe12ac64: called at boot, args inconclusive]

/** Making the card bootable **/
// 1300D, unchecked: NSTUB(   0x499a0,  cf_device)
NSTUB(0x000490f8,  sd_device)                               // 2000D: runtime: sd_device[1]->read_block = sdReadBlk FE636AC8 (1300D addr is WRONG here)
NSTUB(0xfe544fc8,  fsuDecodePartitionTable)                 // 2000D: struct: decodes MBR entry (status, CHS, type, LBA)

/** Memory allocation **/
NSTUB(0xfe128298,  GetMemoryInformation)                    // 2000D: struct: called from _AllocateMemory (+0x9D0)
NSTUB(0xfe128244,  GetSizeOfMaxRegion)                      // 2000D: struct: called from _AllocateMemory (+0x9D0)
NSTUB(0xfe1284f8,  _AllocateMemory)                         // 2000D: probe: r0 = sizes 0x418, 0x11e8
NSTUB(0xfe128894,  _FreeMemory)                             // 2000D: probe: r0 = heap pointers
NSTUB(0xfe2c254c,  _alloc_dma_memory)                       // 2000D: struct: AllocateMemory(size+0x40), align, |0x40000000
NSTUB(0xfe2c6c28,  _free)                                   // 2000D: probe: frees memory-suite objects
NSTUB(0xfe2c2588,  _free_dma_memory)                        // 2000D: struct: &~0x40000000, header, b _FreeMemory
NSTUB(0xfe2c6bd0,  _malloc)                                 // 2000D: probe: sizes from kernel allocator
// NSTUB(    ???,  free_dma_memory)                         /* present on 7D_MASTER.203 */

/** Message queues **/
NSTUB(0x00007868,  msg_queue_count)                         // 2000D: probe: r0 = queue id
NSTUB(0x00007480,  msg_queue_create)                        // 2000D: probe: r0 = "DbgMgr", "Startup"
NSTUB(0x00007814,  msg_queue_post)                          // 2000D: probe: queue 0x360002, received by DbgMgr
NSTUB(0x000075d0,  msg_queue_receive)                       // 2000D: probe: DbgMgr task receives on 0x360002

/** PTP **/
// 1300D, unchecked: NSTUB(0xFE36ED54,  ptp_register_handler)   [2000D candidate 0xfe36df20: cluster shift -0xe34 (1/1 aligned, runner-up 1), not exercised]
// 1300D, unchecked: NSTUB(0xFE1FDBE8,  ptpPropSetUILock)                        /* present on 650D.104, 700D.113 */   [2000D candidate 0xfe1fce44: cluster shift -0xda4 (1/1 aligned, runner-up 1), not exercised]

/** Properties **/
NSTUB(0xfe10c5e0,  _prop_cleanup)                           // 2000D: probe: PropMgr, (token, 0x80000000..)
NSTUB(0xfe10be44,  _prop_request_change)                    // 2000D: probe: (0x2000002, ptr, 4)
NSTUB(0xfe10c438,  prop_deliver)                            // 2000D: probe: (.., .., len 4) from PropMgr
NSTUB(0xfe10c4c0,  prop_register_slave)                     // 2000D: probe: (prop list, count, cbr)
// NSTUB(    ???,  prop_unregister_slave)                   /* present on 7D.203 */

/** Recursive locks **/
NSTUB(0x0000bcb8,  AcquireRecursiveLock)                    // 2000D: probe: lock 0x860002, paired with Release
NSTUB(0x0000bbf8,  CreateRecursiveLock)                     // 2000D: probe: r0 = "ReceiptRecursiveLock"
NSTUB(0x0000be28,  ReleaseRecursiveLock)                    // 2000D: probe: lock 0x860002

/** ResLock **/
NSTUB(0xfe2a21b4,  CreateResLockEntry)                      // 2000D: probe: (list, 0x27)
NSTUB(0xfe2a26f4,  LockEngineResources)                     // 2000D: bracket -0x4B4
NSTUB(0xfe2a282c,  UnLockEngineResources)                   // 2000D: probe: ImgPlayDrv after EDMAC transfer

/** Semaphores **/
NSTUB(0x000030c8,  create_named_semaphore)                  // 2000D: probe: r0 = "OriginalMemorySuite"
NSTUB(0x00003358,  give_semaphore)                          // 2000D: probe: sem id 0x180014; log votes "GiveSemaphore" 8/8
NSTUB(0x00003270,  take_semaphore)                          // 2000D: probe: same sem id 0x180014 as give_semaphore

/** Task info **/
NSTUB(0x000358e8,  task_max)                                // 2000D: read by init_task

NSTUB(    0x24C4,  _get_task_info_by_id)                    // 2000D: reads current_task 0x31170
NSTUB(   0x31170,  current_task)                            // 2000D: read by _get_task_info_by_id; holds task ptr at init_task
NSTUB(     0x640,  current_interrupt)                       // 2000D: IRQ handler (RAM 0x508) stores MEM(C0201004) here

/* wifi  */
/*
// 1300D, unchecked: NSTUB(0xFE43005C, nif_setup)   [2000D candidate 0xfe42f218: cluster shift -0xe44 (1/2 aligned, runner-up 1), not exercised]
// 1300D, unchecked: NSTUB(0xFE42fd44, rt_edit)
// 1300D, unchecked: NSTUB(0xFE443964, wlanconnect)   [2000D candidate 0xfe442a18: cluster shift -0xf4c (1/1 aligned, runner-up 1), not exercised]

// 1300D, unchecked: NSTUB(0x000140CC, _socket_create)
// 1300D, unchecked: NSTUB(0x000142BC, _socket_bind)
// 1300D, unchecked: NSTUB(0x000143B0, _socket_connect)
// 1300D, unchecked: NSTUB(0x00014334, _socket_listen)
// 1300D, unchecked: NSTUB(0x00014468, _socket_accept)
// 1300D, unchecked: NSTUB(0x00014670, _socket_recv)
// 1300D, unchecked: NSTUB(0x00014920, _socket_send)
// 1300D, unchecked: NSTUB(0x00014DE4, _socket_setsockopt)
*/

/** Task sleep **/
NSTUB(    0x3780,  msleep)                                  // 2000D: gdb: r0 = 10, 30 (ms)

/** Tasks **/
NSTUB(0x0003592c,  task_dispatch_hook)                      // 2000D: context switch (0x1D04 etc.) loads, tests and calls *(0x3592C); 1300D 0x35924 is NOT the hook here
NSTUB(    0x38FC,  task_create)                             // 2000D: gdb: r0 = "PowerMgr", "Startup", "PropMgr"...
NSTUB(0x000041dc,  task_trampoline)                         // 2000D: every task starts here (lr = stack fill 0x19980218)
// NSTUB(    ???,  current_task_ctx)                        /* present on 7D.203 */
// NSTUB(    ???,  next_task_ctx)                           /* present on 7D.203 */

/** Misc **/
// 1300D, unchecked: NSTUB(   0x6D418,  lv_path_struct)                          // first arg of SelectPathDriveMode
NSTUB(0xfe11b5a4,  LoadCalendarFromRTC)                     // 2000D: probe: r0 = calendar struct, from date dialog
NSTUB(0xfe2bc8c8,  vsnprintf)                               // 2000D: probe: called by DryosDebugMsg as (buf, size, fmt, va)
//NSTUB(0xFE0180A8,  _print_serial)
//NSTUB( 0xff37aee4, ChangeHDMIOutputSizeToFULLHD)
//NSTUB( 0xff37b174, ChangeHDMIOutputSizeToVGA)
// 1300D, unchecked: NSTUB(0xFE114B20,  EnableImagePhysicalScreenParameter)      /* present on 7D.203, 50D.109, 5D2.212 */   [2000D: shift guess 0xfe113bbc WRONG: is SetBitmapVramAddress (logs that string)]
// NSTUB(    ???,  FSUunMountDevice)                        /* present on 5D3.113 */
// NSTUB(    ???,  PtpDps_remote_release_SW1_SW2_worker)    /* present on 7D.203, 5D2.212 */
// NSTUB(    ???,  memcpy)                                  /* present on 7D_MASTER.203 */

// 1300D, unchecked: NSTUB(0xfe0d48b4,  TryReceiveMessageQueue)   [2000D candidate 0xfe0d58d0: cluster shift +0x101c (2/2 aligned, runner-up 2), not exercised]
