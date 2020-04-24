import numpy as np
import matplotlib.pyplot as plt

m = np.loadtxt('output_teste_3.txt', dtype='float', delimiter=' ')

y = m[:, 2]
z = y > 100

print(sum(z))
