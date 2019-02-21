import numpy as np
import matplotlib.pyplot as plt
import random as rand
import os

#init matrix, chaos shape, chaos factor
g = np.zeros((1000,1000), dtype='int16')
hex_vertices = (np.array([100,500]), np.array([300,846]), np.array([700,846]), np.array([900,500]), np.array([700,154]), np.array([300,154]))
tri_vertices = (hex_vertices[0], hex_vertices[2], hex_vertices[4])
rhomb_vertices = (hex_vertices[0], hex_vertices[1], hex_vertices[3], hex_vertices[4])
hex_angles = (np.radians(0),np.radians(0),np.radians(0),np.radians(0),np.radians(0),np.radians(0))
R_transforms=[]
for alpha in hex_angles:
    c, s = np.cos(alpha), np.sin(alpha)
    R_transforms.append(np.array(((c,-s), (s, c))))
factor = 3

start_point = np.array([rand.randint(1,998),rand.randint(1,998)])
move_point = start_point

def chaos_game(counter, record = True):
    global move_point
    global g
    global R_transforms
                        
    for i in range(1,counter,1):
        k = rand.randint(0,5)
        R = R_transforms[k]
        rand_vertex = hex_vertices[k]
        dist = np.array(R.dot(rand_vertex - move_point), dtype = 'int16')
        move_point = rand_vertex - dist//factor
        if record == True:
            g[move_point[0],move_point[1]] = 1
    return g

#graph bit
g = chaos_game(10000, record = False)

fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2)
plt.subplots_adjust(hspace=0.3)

g = chaos_game(100)

ax1.set_title('100 iterations')
ax1.imshow(g, cmap='Greys',  interpolation='nearest')

g = chaos_game(1000)

ax3.set_title('1000 iterations')
ax3.imshow(g, cmap='Greys',  interpolation='nearest')

g = chaos_game(10000)

ax2.set_title('10000 iterations')
ax2.imshow(g, cmap='Greys',  interpolation='nearest')

g = chaos_game(100000)

ax4.set_title('100000 iterations')
ax4.imshow(g, cmap='Greys',  interpolation='nearest')

plt.savefig('chaos_games.png')
plt.show()

''' option to display single plot
g = chaos_game(100000)
plt.imshow(g, cmap='Greys',  interpolation='nearest')
plt.subplot(2,1,2)
g = chaos_game(100000)
plt.imshow(g, cmap='Greys',  interpolation='nearest')
plt.savefig('chaos_games.png')
'''
