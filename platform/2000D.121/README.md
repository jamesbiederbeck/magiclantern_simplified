# EOS 2000D / Rebel T7 / Kiss X90, firmware 1.2.1: work in progress

**Status: QEMU only. Not tested on a physical camera. Do not run this on a real camera yet.**

This port is derived from `1300D.110`. The full build boots in qemu-eos (2000D model with 512 MB RAM and
ROM0 mapped) and shows the ML menu, and every tab renders.

- `stubs.S`: entries marked `2000D:` were verified against the 1.2.1 ROM, by disassembly, unique string or data
  references, or by watching the firmware call them with matching arguments under gdb in qemu-eos. `PROBABLE`
  and `PLACEHOLDER` entries are marked as such. Commented `1300D, unchecked` lines are not used.
- `consts.h`: values marked `2000D:` were checked; values marked `unverified 1300D value` were not.
- Placeholders: `PlayMain_handler` and `PlayMovieGuideApp_handler` are 0 (play-mode detection is off).
  `GetCFnData`/`SetCFnData` are not found, so `cfn.c` returns 0. The RAW colour matrix, dynamic ranges and
  FPS timer constants are 1300D values (different sensor); those features are not enabled.
- Unchecked on hardware: the card LED GPIO, the EDMAC channels used in LiveView, and the button codes. In
  particular, on the 2000D the Av button event does not reach GuiMainTask, so the ML menu currently opens
  only with Trash/Erase in qemu.

Emulation needs qemu-eos with a 2000D model: 512 MB RAM, `firmware_start` 0xFE0C0000, ROM0 mapped, and the
64 KB boot block at ROM1 offset 0x10000 copied to 0x1FF0000 (the same layout as the 1300D).

LLM disclosure (see `LLM_POLICY.md`): the reverse engineering, verification and these platform files were
produced with substantial help from an LLM (Claude). Treat this as research notes and a reference; it is not
ready to merge upstream as-is.
