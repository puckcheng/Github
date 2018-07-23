import vapoursynth as vs
import sys
import havsfunc as haf
import mvsfunc as mvf
core = vs.get_core(accept_lowercase=True,threads=12)
core.max_cache_size=8000
Source=r'Z:\迅雷下载\1920s\Das Wachsfigurenkabinett, 1924 (Leni) [DVD5-Kino_RusSub]\VIDEO_TS\VIDEO_TS.demuxed.m2v'
src=core.lsmas.LWLibavSource(Source,threads=1)
#src=core.ffms2.Source(Source)
clip=haf.QTGMC(src,Preset="Slow",TFF=True)
#SM=haf.SMDegrain(src,tr=2,thSAD=300,contrasharp=True,chroma=False,plane=0)
#src=core.std.Trim(src,153123,188381)
clip=clip[::2]
BM3D=mvf.BM3D(clip,sigma=[8,0,0],radius1=0,profile1="lc")
BM3D.set_output()
