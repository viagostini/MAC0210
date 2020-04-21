import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import FormatStrFormatter

# This opens a handle to your file, in 'r' read mode
file_handle = open('output_test.txt', 'r')

f = file_handle.readlines()

m = [[0] * 1000 for i in range(1000)]

c = 0
idx = 0
for line in f:
    if int(line.split()[2]) == -1:
        c += 1
    m[idx//1000][idx%1000] = int(line.split()[2])
    idx += 1
print(c)

plt.imshow(m, cmap='hot', extent=[-2,2,-2,2])
plt.show()



""" x, y = [float(val) for val in ids[0].split()[:2]]
root = [int(val) for val in ids[0].split()[3]]

my_data = [[int(val) for val in line.split()] for line in ids[1:]]

root_id = [i[0] for i in my_data]
iters = np.array([i[1] for i in my_data])

root_matrix = np.transpose(np.reshape(root_id,(p1, p2)))
iters = np.transpose(np.reshape(iters,(p1, p2)))

log_iters = np.ma.log(iters/np.max(iters)).filled(0)
#root_matrix = root_matrix - 0.99 * log_iters """

#fig = plt.figure(figsize=(1000/96,1000/96), dpi=96)

""" fig = plt.figure()
ax = fig.add_subplot(111)
cax = ax.matshow(root_matrix, interpolation='none', origin='lower')

ax.xaxis.set_ticks_position('bottom')

xticks = np.linspace(0, p1, 5)
xlabels = np.round(np.linspace(l1, u1, 5), 2)

yticks = np.linspace(0, p2, 5)
ylabels = np.round(np.linspace(l2, u2, 5), 2)

ax.set_xticks(xticks)
ax.set_xticklabels(xlabels, fontsize=12)
ax.set_yticks(xticks)
ax.set_yticklabels(xlabels, fontsize=12)
plt.show()
fig.savefig('figure3.png') """