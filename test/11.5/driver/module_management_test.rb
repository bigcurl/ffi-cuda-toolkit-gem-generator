# frozen_string_literal: true
# Needed
# CUresult cuModuleGetFunction ( CUfunction* hfunc, CUmodule hmod, const char* name )
# CUresult cuModuleGetGlobal ( CUdeviceptr* dptr, size_t* bytes, CUmodule hmod, const char* name )
# CUresult cuModuleLoad ( CUmodule* module, const char* fname )
# CUresult cuModuleLoadData ( CUmodule* module, const void* image )
# CUresult cuModuleLoadDataEx ( CUmodule* module, const void* image, unsigned int  numOptions, CUjit_option* options, void** optionValues )
# CUresult cuModuleLoadFatBinary ( CUmodule* module, const void* fatCubin )
# CUresult cuModuleUnload ( CUmodule hmod )

# Not needed
# CUresult cuLinkAddData ( CUlinkState state, CUjitInputType type, void* data, size_t size, const char* name, unsigned int  numOptions, CUjit_option* options, void** optionValues )
# CUresult cuLinkAddFile ( CUlinkState state, CUjitInputType type, const char* path, unsigned int  numOptions, CUjit_option* options, void** optionValues )
# CUresult cuLinkComplete ( CUlinkState state, void** cubinOut, size_t* sizeOut )
# CUresult cuLinkCreate ( unsigned int  numOptions, CUjit_option* options, void** optionValues, CUlinkState* stateOut )
# CUresult cuLinkDestroy ( CUlinkState state )
# CUresult cuModuleGetSurfRef ( CUsurfref* pSurfRef, CUmodule hmod, const char* name )
# CUresult cuModuleGetTexRef ( CUtexref* pTexRef, CUmodule hmod, const char* name )
