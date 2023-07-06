from __future__ import absolute_import
import sympy
from .stepprinter import *

from sympy.integrals.manualintegrate import (
    manualintegrate, integral_steps,
    ConstantRule, ConstantTimesRule, PowerRule, AddRule, URule,
    PartsRule, CyclicPartsRule, TrigRule, ExpRule, ReciprocalRule, ArctanRule,
    AlternativeRule, DontKnowRule, RewriteRule
)

# Need this to break loops
# TODO: add manualintegrate flag to integrate
_evaluating = None
def eval_dontknow(context, symbol):
    global _evaluating
    if _evaluating == context:
        return None
    _evaluating = context
    result = sympy.integrate(context, symbol)
    _evaluating = None
    return result


def contains_dont_know(rule):
    if isinstance(rule, DontKnowRule):
        return True
    else:
        sub = rule
        count = 0

        #prevents infinite loop for ReciprocalRule
        while hasattr(sub,'substep') and count > 100:
            if isinstance(sub, DontKnowRule): 
                return True
            sub = rule.substep
            count += 1
    
    return False

def filter_unknown_alternatives(rule):
    if isinstance(rule, AlternativeRule):
        alternatives = list([r for r in rule.alternatives if not contains_dont_know(r)])
        if not alternatives:
            alternatives = rule.alternatives
        return AlternativeRule(rule.integrand, rule.variable, alternatives)
    return rule

class IntegralPrinter(object):
    def __init__(self, rule):
        self.rule = rule
        self.print_rule(rule)
        self.u_name = 'u'
        self.u = self.du = None

    def print_rule(self, rule):
        if isinstance(rule, ConstantRule):
            self.print_Constant(rule)
        elif isinstance(rule, ConstantTimesRule):
            self.print_ConstantTimes(rule)
        elif isinstance(rule, PowerRule):
            self.print_Power(rule)
        elif isinstance(rule, AddRule):
            self.print_Add(rule)
        elif isinstance(rule, URule):
            self.print_U(rule)
        elif isinstance(rule, PartsRule):
            self.print_Parts(rule)
        elif isinstance(rule, CyclicPartsRule):
            self.print_CyclicParts(rule)
        elif isinstance(rule, TrigRule):
            self.print_Trig(rule)
        elif isinstance(rule, ExpRule):
            self.print_Exp(rule)
        elif isinstance(rule, ReciprocalRule):
            self.print_Log(rule)
        elif isinstance(rule, ArctanRule):
            self.print_Arctan(rule)
        elif isinstance(rule, AlternativeRule):
            self.print_Alternative(rule)
        elif isinstance(rule, DontKnowRule):
            self.print_DontKnow(rule)
        elif isinstance(rule, RewriteRule):
            self.print_Rewrite(rule)
        else:
            print(repr(rule))

        #TODO: add piecewiseRule function
        #TODO: add SqrtQuadraticRule

    def print_Constant(self, rule):
        print("The integral of a constant is the constant "
                    "times the variable of integration:")
        print(
            latex(
                sympy.Eq(sympy.Integral(rule.integrand, rule.variable),
                        manualintegrate(rule.integrand, rule.variable))))

    def print_ConstantTimes(self, rule):
        print("The integral of a constant times a function "
                    "is the constant times the integral of the function:")
        print(latex(
            sympy.Eq(
                sympy.Integral(rule.integrand, rule.variable),
                rule.constant * sympy.Integral(rule.other, rule.variable))))

  
        self.print_rule(rule.substep)
        print("So, the result is: {}".format(
            latex(manualintegrate(rule.integrand, rule.variable))))

    def print_Power(self, rule):
        print("The integral of {} is {} when {}:".format(
            latex(rule.variable ** sympy.Symbol('n')),
            latex((rule.variable ** (1 + sympy.Symbol('n'))) /
                                (1 + sympy.Symbol('n'))),
            latex(sympy.Ne(sympy.Symbol('n'), -1)),
        ))
        print(
            latex(
                sympy.Eq(sympy.Integral(rule.integrand, rule.variable),
                        manualintegrate(rule.integrand, rule.variable))))

    def print_Add(self, rule):
        print("Integrate term-by-term:")
        for substep in rule.substeps:
           self.print_rule(substep)
        print("The result is: {}".format(
            latex(manualintegrate(rule.integrand, rule.variable))))
        
    @contextmanager
    def new_u_vars(self):
        self.u, self.du = sympy.Symbol('u'), sympy.Symbol('du')
        yield self.u, self.du

    def print_U(self, rule):
        with self.new_u_vars() as (u, du):
            # commutative always puts the symbol at the end when printed
            dx = sympy.Symbol('d' + str(rule.variable), commutative=0)
            print("Let {}.".format(
                latex(sympy.Eq(u, rule.u_func))))
            print("Then let {} and substitute {}:".format(
                latex(sympy.Eq(du, rule.u_func.diff(rule.variable) * dx)),
                latex(rule.variable * du)
            ))

            integrand = rule.substep.integrand
            print(latex(
                sympy.Integral(integrand, u)))

            
            self.print_rule(rule.substep)

            print("Now substitute {} back in:".format(
                latex(u)))

            print(latex(manualintegrate(rule.integrand,rule.variable)))

    def print_Parts(self, rule):
        print("Use integration by parts:")

        u, v, du, dv = [sympy.Function(f)(rule.variable) for f in 'u v du dv'.split()]
        print(latex(
            r"""\int \operatorname{u} \operatorname{dv}
            = \operatorname{u}\operatorname{v} -
            \int \operatorname{v} \operatorname{du}"""
        ))

        print("Let {} and let {}.".format(
            latex(sympy.Eq(u, rule.u)),
            latex(sympy.Eq(dv, rule.dv))
        ))
        print("Then {}.".format(
            latex(sympy.Eq(du, rule.u.diff(rule.variable)))
        ))

        print("To find {}:".format(latex(v)))

        self.print_rule(rule.v_step)

        print("Now evaluate the sub-integral.")
        self.print_rule(rule.second_step)

    def print_CyclicParts(self, rule):
        print("Use integration by parts, noting that the integrand"
                    " eventually repeats itself.")

        u, v, du, dv = [sympy.Function(f)(rule.variable) for f in 'u v du dv'.split()]
        current_integrand = rule.integrand
        total_result = sympy.S.Zero
      
        sign = 1
        for rl in rule.parts_rules:      
            print("For the integrand {}:".format(latex(current_integrand)))
            print("Let {} and let {}.".format(
                latex(sympy.Eq(u, rl.u)),
                latex(sympy.Eq(dv, rl.dv))
            ))

            v_f, du_f = manualintegrate(rl.v_step.integrand, rl.v_step.variable), rl.u.diff(rule.variable)

            total_result += sign * rl.u * v_f
            current_integrand = v_f * du_f

            print("Then {}.".format(
                latex(
                    sympy.Eq(
                        sympy.Integral(rule.integrand, rule.variable),
                        total_result - sign * sympy.Integral(current_integrand, rule.variable)))
            ))
            sign *= -1
      
        print("Notice that the integrand has repeated itself, so "
                    "move it to one side:")
        print("{}".format(
            latex(sympy.Eq(
                (1 - rule.coefficient) * sympy.Integral(rule.integrand, rule.variable),
                total_result
            ))
        ))
        print("Therefore,")
        print("{}".format(
            print(sympy.Eq(
                sympy.Integral(rule.integrand, rule.variable),
                manualintegrate(rule.integrand, rule.variable)
            ))
        ))


    def print_Trig(self, rule):
        text = {
            'sin': "The integral of sine is negative cosine:",
            'cos': "The integral of cosine is sine:",
            'sec*tan': "The integral of secant times tangent is secant:",
            'csc*cot': "The integral of cosecant times cotangent is cosecant:",
        }.get(rule.integrand)

        if text:
            print(text)

        print(latex(
            sympy.Eq(sympy.Integral(rule.integrand, rule.variable),
                    manualintegrate(rule.integrand, rule.variable))))

    def print_Exp(self, rule): 
        if rule.base == sympy.E:
            print("The integral of the exponential function is itself.")
        else:
            print("The integral of an exponential function is itself"
                        " divided by the natural logarithm of the base.")
        print(latex(
            sympy.Eq(sympy.Integral(rule.integrand, rule.variable),
                    manualintegrate(rule.integrand, rule.variable))))

    def print_Log(self, rule):
        print("The integral of {} is {}.".format(
            latex(1 / rule.integrand),
            latex(manualintegrate(rule.integrand, rule.variable))
        ))
       

    def print_Arctan(self, rule):
        print("The integral of {} is {}.".format(
            latex(1 / (1 + rule.variable ** 2)),
            latex(manualintegrate(rule.integrand, rule.variable))
        ))

    def print_Rewrite(self, rule):
            print("Rewrite the integrand:")
            print(latex(
                sympy.Eq(rule.integrand, rule.rewritten)))
            self.print_rule(rule.substep)

    def print_DontKnow(self, rule):
        print("Don't know the steps in finding this integral.")
        print("But the integral is")
        print(latex(sympy.integrate(rule.integrand, rule.variable)))


    def print_Alternative(self, rule):
        # TODO: make more robust
        rule = filter_unknown_alternatives(rule)
    
        if len(rule.alternatives) == 1:
            self.print_rule(rule.alternatives[0])
            return

        if hasattr(rule,'func'):
            self.print_rule(rule.alternatives[0])
        else:
            print("There are multiple ways to do this integral.")
            for index, r in enumerate(rule.alternatives):
                    print("Method #{}".format(index + 1))
                    self.print_rule(r)

