import nltk

# Convert a CFG to CNF
cfg = nltk.CFG.fromstring("""
    S -> AB | BC
    A -> BA | a
    B -> CC | b
    C -> AB | a
""")
cnf = cfg.chomsky_normal_form()
print(cnf)

# Convert CNF back to CFG
new_cfg = cnf.to_cfg()
print(new_cfg)