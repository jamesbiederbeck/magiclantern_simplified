#include <dryos.h>
#include <property.h>
#include <cfn-generic.h>

// 2000D WIP: GetCFnData / SetCFnData are not located yet, so custom functions
// read as "off" and writes are ignored. Restore the 1300D versions once found.

int get_htp() { return 0; }
void set_htp(int value) { return; }

// No MLU on the 2000D
int get_mlu() { return 0; }
void set_mlu(int value) { return; }

int cfn_get_af_button_assignment() { return 0; }
void cfn_set_af_button(int value) { return; }

GENERIC_GET_ALO
