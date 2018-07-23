import vapoursynth as vs
import sys
import havsfunc as haf
import mvsfunc as mvf
core = vs.get_core(accept_lowercase=True,threads=12)
core.max_cache_size=8000
Source=r'D:\Media\TEMP\mchd-bohem720p_12-43-08.mkv'
src=core.lsmas.LWLibavSource(Source,threads=1)
#src=core.ffms2.Source(Source)
#clip=haf.QTGMC(src,Preset="Slow",TFF=True)
#SM=haf.SMDegrain(src,tr=2,thSAD=300,contrasharp=True,chroma=False,plane=0)
#src=core.std.Trim(src,153123,188381)
#clip=clip[::2]
BM3D=mvf.BM3D(src,sigma=[10,0,0],radius1=0,profile1="lc")
BM3D.set_output()
