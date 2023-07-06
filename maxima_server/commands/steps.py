from sympy.integrals.manualintegrate import *
from sympy.parsing.sympy_parser import parse_expr
from sympy.abc import x
import sys
from sympy_gamma.intsteps import *
from sympy_gamma.diffsteps import *

mode = sys.argv[1]
expr = parse_expr(sys.argv[2])

if mode == "diff":
    DiffPrinter(diff_steps(expr, x))
elif mode == "int":
    IntegralPrinter(integral_steps(expr, x))


   

