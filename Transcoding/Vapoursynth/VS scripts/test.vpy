import vapoursynth as vs
import sys
core = vs.get_core(accept_lowercase=True,threads=6)
core.max_cache_size=8000
source=r'D:\Media\FOOTAGE\Prince Albert National Park\Video\P1033238.MP4'
src=core.lsmas.LWLibavSource(source,threads=1)
src=core.std.SetFrameProp(src, prop="_FieldBased",intval=0)
src.set_output()