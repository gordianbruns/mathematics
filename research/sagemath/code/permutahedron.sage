from sage.graphs.independent_sets import IndependentSets

n = 5
permutations = Permutations(n)
#for perm in permutations:
#    print(perm)

def get_faces(permutation):
    positions = {}
    positions_list = []
    faces = []
    n = len(permutation)
    for i in range(n):
        positions[permutation[i]] = i + 1
    for i in range(n):
        positions_list.append(positions[i + 1])
    face = []
    for i in range(n-1):
        for j in range(i+1):
            face.append(positions_list[j])
        face.sort()
        faces.append(face)
        face = []
    return faces

perm1 = [1, 3, 5, 2, 4]
perm2 = [1, 4, 2, 5, 3]
positions1 = get_faces(perm1)
print(positions1)
positions2 = get_faces(perm2)
print(positions2)

def share_facet(permutation1, permutation2):
    faces1 = get_faces(permutation1)
    faces2 = get_faces(permutation2)
    for i in range(len(faces1)):
        if faces1[i] == faces2[i]:
            return True
    return False

print(share_facet(perm1, perm2))


# computes the degree of each permutation where they are adjacent if they do not share a facet
def get_degrees(permutations):
    degree = {}
    summation = 0
    for perm1 in permutations:
        for perm2 in permutations:
            if perm1 != perm2 and share_facet(perm1, perm2) == False:
                summation += 1
        degree[perm1] = summation
        summation = 0
    return degree

#degrees = get_degrees(permutations)
#print(degrees)


# computes the degree of a single permutation
def get_degree(perm):
    permutations = Permutations(len(perm))
    summation = 0
    for perm2 in permutations:
        if perm1 != perm2 and share_facet(perm, perm2) == False:
            summation += 1
    return summation

#degree = get_degree([1, 2, 3, 4, 5, 6, 7])
#print(degree)

def create_graph(vertex_set):
    G = Graph()
    G.add_vertices(vertex_set)
    for i in range(len(vertex_set)):
        for j in range(i + 1, len(vertex_set)):
            if share_facet(vertex_set[i], vertex_set[j]) == False:
                G.add_edge(vertex_set[i], vertex_set[j])
    
    return G

G = create_graph(permutations)
print(G)

def get_independence_number(graph):
    # gives inclusion maximal sets
    Im = IndependentSets(graph, maximal=True)
    ind_num = 0
    y = 0
    for x in Im:
        if len(x) > ind_num:
            ind_num = len(x)
            y = x
    print(y)
    return ind_num

ind_num = get_independence_number(G)
print(ind_num)

G_bar = G.complement()
'''print("Adjacency List of G:")
for v in G.vertices():
    print(f"{v}: {G.neighbors(v)}")

print("Adjacency List of G_bar:")
for v in G_bar.vertices():
    print(f"{v}: {G_bar.neighbors(v)}")'''

print(get_independence_number(G_bar))