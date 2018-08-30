import vapoursynth as vs
import sys
core = vs.get_core(accept_lowercase=True,threads=6)
core.max_cache_size=8000
source=r'D:\Media\FOOTAGE\Regina Folk Festival\P1011283_arc.MP4'
src=core.lsmas.LWLibavSource(source,threads=1).text.ClipInfo()
src=core.std.SetFrameProp(src, prop="_FieldBased",intval=0)
src.set_output()