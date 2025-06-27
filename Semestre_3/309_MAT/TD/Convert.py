def ecriturebase(N, b):
	L = []
	while N > 0:
		L.append(N % b)
		N = N // b
	return L

print(ecriturebase(10, 2))    # Output: [0, 1, 0, 1, 0]
print(ecriturebase(1234,16))  # Output: [2, 13, 4]