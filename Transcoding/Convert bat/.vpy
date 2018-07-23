import vapoursynth as vs 
import sys 
import havsfunc as haf 
import mvsfunc as mvf 
core = vs.get_core(accept_lowercase=True,threads=14) 
core.max_cache_size=8000 
Source=r'' 
src=core.lsmas.LWLibavSource(Source,threads=1) 
#src=core.ffms2.Source(Source) 
src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0) 
#SM=haf.SMDegrain(src,tr=2,thSAD=300,contrasharp=True,chroma=False,plane=0) 
src=core.std.Trim(src,0,-1) 
BM3D=mvf.BM3D(src,sigma=[8,0,0],radius1=0,profile1="lc") 
BM3D.set_output() 
