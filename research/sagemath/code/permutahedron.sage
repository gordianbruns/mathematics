from sage.graphs.independent_sets import IndependentSets

n = 4
permutations = Permutations(n)
permutahedron = polytopes.permutahedron(n)
print("Permutahedron with n =", n)

#print(face_list.matrix())
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

'''perm1 = [1, 3, 5, 2, 4]
perm2 = [1, 4, 2, 5, 3]
positions1 = get_faces(perm1)
print(positions1)
positions2 = get_faces(perm2)
print(positions2)'''

def share_facet(permutation1, permutation2):
    faces1 = get_faces(permutation1)
    faces2 = get_faces(permutation2)
    for i in range(len(faces1)):
        if faces1[i] == faces2[i]:
            return True
    return False

#print(share_facet(perm1, perm2))

#TODO: Fix share_facet2
def share_facet2(permutation1, permutation2):
    perm1_minimum1 = len(permutation1)
    perm1_minimum2 = len(permutation1)
    perm2_minimum1 = len(permutation2)
    perm2_minimum2 = len(permutation2)
    for i in range(len(permutation1)):
        if perm1_minimum1 > permutation1[i]:
            perm1_minimum1 = permutation1[i]
        if perm2_minimum1 > permutation2[i]:
            perm2_minimum1 = permutation2[i]
        for j in range(i, len(permutation1)):
            if perm1_minimum2 > permutation1[j]:
                perm1_minimum2 = permutation1[j]
            if perm2_minimum2 > permutation2[j]:
                perm2_minimum2 = permutation2[j]
        if perm1_minimum1 < perm1_minimum2 and perm2_minimum1 < perm2_minimum2:
            first_entries1 = permutation1[:i].sort()
            first_entries2 = permutation2[:i].sort()
            if first_entries1 == first_entries2:
                return True
        perm1_minimum2 = len(permutation1)
        perm2_minimum2 = len(permutation2)
    return False

'''perm1 = [1, 2, 3]
perm2 = [2, 1, 3]
print(share_facet2(perm1, perm2))'''

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

'''p = [1, 2, 3, 4, 5]
degree = get_degree(p)
print("Degree of", p, ":", degree)'''

def share_facet4(perm1, perm2):
    for f in permutahedron.facets():
        if perm1 in f.vertices() and perm2 in f.vertices():
            return True
    return False

def create_graph(vertex_set):
    G = Graph()
    G.add_vertices(vertex_set)
    for i in range(len(vertex_set)):
        for j in range(i + 1, len(vertex_set)):
            if share_facet4(vertex_set[i], vertex_set[j]) == False:
                G.add_edge(vertex_set[i], vertex_set[j])
    return G

G = create_graph(permutahedron.vertices())
#print(G)

def get_independence_number(graph):
    # gives inclusion maximal sets
    Im = IndependentSets(graph, maximal=True)
    ind_num = 0
    y = 0
    for x in Im:
        if len(x) > ind_num:
            ind_num = len(x)
            y = x
    print('Maximal set:', y)
    return ind_num

ind_num = get_independence_number(G)
print("Independence number:", ind_num)

G_bar = G.complement()

print("Clique number:", get_independence_number(G_bar))

print("Eigenvalues:", G.spectrum())

def get_maximal_independent_sets(graph):
    Im = IndependentSets(graph, maximal=True)
    max_ind_sets = []
    for x in Im:
        if len(x) == ind_num:
            max_ind_sets.append(x)
    return max_ind_sets

max_ind_sets = get_maximal_independent_sets(G)
counter = 1
for ind in max_ind_sets:
    print("Independent set no.", counter, ":", ind)
    counter += 1