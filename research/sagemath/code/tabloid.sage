from sage.graphs.independent_sets import IndependentSets

partition = [3,4]
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

def tabloid_intersect(t_1, t_2):
    for i in range(len(t_1)):
        if t_1[i].intersection(t_2[i]):
            return True
    return False

def create_graph(vertex_set):
    G = Graph()
    G.add_vertices(vertex_set)
    for i in range(len(vertex_set)):
        for j in range(i + 1, len(vertex_set)):
            if tabloid_intersect(vertex_set[i], vertex_set[j]) == False:
                G.add_edge(vertex_set[i], vertex_set[j])
    return G

G = create_graph(tabloids)
print(G)
print(G.degree(G.vertices()))

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

#G_bar = G.complement()

#print("Clique number:", get_independence_number(G_bar))

print("Eigenvalues:", G.spectrum())

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