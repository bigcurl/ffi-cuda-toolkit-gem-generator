# Needed
# CUresult cuStreamCreate ( CUstream* phStream, unsigned int  Flags )
# CUresult cuStreamCreateWithPriority ( CUstream* phStream, unsigned int  flags, int  priority )
# CUresult cuStreamDestroy ( CUstream hStream )
# CUresult cuStreamBeginCapture ( CUstream hStream, CUstreamCaptureMode mode )
# CUresult cuStreamEndCapture ( CUstream hStream, CUgraph* phGraph )
# CUresult cuStreamAddCallback ( CUstream hStream, CUstreamCallback callback, void* userData, unsigned int  flags )
# CUresult cuStreamAttachMemAsync ( CUstream hStream, CUdeviceptr dptr, size_t length, unsigned int  flags )
# CUresult cuStreamQuery ( CUstream hStream )
# CUresult cuStreamSynchronize ( CUstream hStream )

# Not needed
# CUresult cuStreamCopyAttributes ( CUstream dst, CUstream src )
# CUresult cuStreamGetAttribute ( CUstream hStream, CUstreamAttrID attr, CUstreamAttrValue* value_out )
# CUresult cuStreamGetCaptureInfo ( CUstream hStream, CUstreamCaptureStatus* captureStatus_out, cuuint64_t* id_out )
# CUresult cuStreamGetCaptureInfo_v2 ( CUstream hStream, CUstreamCaptureStatus* captureStatus_out, cuuint64_t* id_out, CUgraph* graph_out, const CUgraphNode** dependencies_out, size_t* numDependencies_out )
# CUresult cuStreamGetCtx ( CUstream hStream, CUcontext* pctx )
# CUresult cuStreamGetFlags ( CUstream hStream, unsigned int* flags )
# CUresult cuStreamGetPriority ( CUstream hStream, int* priority )
# CUresult cuStreamIsCapturing ( CUstream hStream, CUstreamCaptureStatus* captureStatus )
# CUresult cuStreamSetAttribute ( CUstream hStream, CUstreamAttrID attr, const CUstreamAttrValue* value )
# CUresult cuStreamUpdateCaptureDependencies ( CUstream hStream, CUgraphNode* dependencies, size_t numDependencies, unsigned int  flags )
# CUresult cuStreamWaitEvent ( CUstream hStream, CUevent hEvent, unsigned int  Flags )
# CUresult cuThreadExchangeStreamCaptureMode ( CUstreamCaptureMode* mode )
