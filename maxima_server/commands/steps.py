from sympy.integrals.manualintegrate import *
from sympy.parsing.sympy_parser import parse_expr
from sympy.parsing.latex import parse_latex
from sympy.abc import x
import sys
from sympy_gamma.intsteps import *
from sympy_gamma.diffsteps import *

mode = sys.argv[1]

if mode == "diff":
    expr = parse_expr(sys.argv[2])
    DiffPrinter(diff_steps(expr, x))
elif mode == "int":
    expr = parse_expr(sys.argv[2])
    IntegralPrinter(integral_steps(expr, x))
elif mode == "simplify":
    if sys.argv[3] == "true":
        sys.argv[2].replace("\\\\","\\")
        expr = parse_latex(sys.argv[2])
    else:
        expr = parse_expr(sys.argv[2])
    print(latex(simplify(expr)))


   

