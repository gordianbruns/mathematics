from sage.graphs.independent_sets import IndependentSets

partition = [2,2]
n = sum(partition)
permutations = Permutations(n)

# generates all lambda-tabloids given some partition
def generate_lambda_tabloids(partition):
    n = sum(partition)
    all_elements = set(range(1, n+1))
    tabloids = set()
    
    for perm in permutations:
        tabloid = []
        idx = 0
        for size in partition:
            part = frozenset(perm[idx:idx+size])
            tabloid.append(part)
            idx += size
        tabloids.add(tuple(tabloid))
    
    return list(tabloids)

tabloids = generate_lambda_tabloids(partition)
print(tabloids)

def tabloid_intersect(a, b):
    return False

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

def create_graph(vertex_set):
    G = Graph()
    G.add_vertices(vertex_set)
    for i in range(len(vertex_set)):
        for j in range(i + 1, len(vertex_set)):
            if tabloid_intersect(vertex_set[i], vertex_set[j]) == False:
                G.add_edge(vertex_set[i], vertex_set[j])
    return G

#G = create_graph(permutahedron.vertices())
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

#ind_num = get_independence_number(G)
#print("Independence number:", ind_num)

#G_bar = G.complement()

#print("Clique number:", get_independence_number(G_bar))

#print("Eigenvalues:", G.spectrum())

def get_maximal_independent_sets(graph):
    Im = IndependentSets(graph, maximal=True)
    max_ind_sets = []
    for x in Im:
        if len(x) == ind_num:
            max_ind_sets.append(x)
    return max_ind_sets

#max_ind_sets = get_maximal_independent_sets(G)
#counter = 1
#for ind in max_ind_sets:
#    print("Independent set no.", counter, ":", ind)
#    counter += 1