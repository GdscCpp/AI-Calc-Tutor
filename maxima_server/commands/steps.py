from sympy.integrals.manualintegrate import *
from sympy.parsing.sympy_parser import parse_expr
from sympy.abc import x
from sympy import integrate, latex
import sys
from sympy_gamma.intsteps import *

intg = parse_expr(sys.argv[1])

IntegralPrinter(integral_steps(intg,x))


   

