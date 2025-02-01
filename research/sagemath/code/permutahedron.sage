n = 9
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
degree = {}
degree_num = 0
summation = 0
count = 1

#for perm1 in permutations:
perm1 = [1, 2, 3, 4, 5, 6, 7, 8, 9]
for perm2 in permutations:
    print(count, '/', len(permutations))
    if perm1 != perm2 and share_facet(perm1, perm2) == False:
        summation += 1
    count += 1
#degree[perm1] = summation
degree_num = summation
summation = 0

print(degree_num)