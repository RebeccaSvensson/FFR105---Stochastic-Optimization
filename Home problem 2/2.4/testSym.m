syms x
fString = 'x + 3*x + 2 - 1 - 2*x'
fSym = str2sym(fString)
f = simplify(fSym)