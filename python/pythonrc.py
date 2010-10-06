import os, os.path, sys
from glob import glob
from math import *
import os, re


def pyx():
    import pyximport
    pyximport.install()


def rn(old, new):
    for f in glob("*"):
        os.rename(f, f.replace(old, new))


def rnRE(pattern, new, count=0):
    def subFunc(match):
        return match.group().replace(match.groups()[0], new)
    for f in glob("*"):
        os.rename(f, re.sub(pattern, subFunc, f, count))


def normMedia():
    rnRE(r"([\s_]+)", "_")
    rn("(", "-")
    rn(")", "-")
    rn("[", "-")
    rn("]", "-")
    rn("'", "")
    rnRE(r"\d{1,3}(_*-_*|\._*)", r"_", 1)

