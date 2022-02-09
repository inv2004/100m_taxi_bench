CC=clang++

taxi: taxi.cc
	${CC} -flto -march=native -Ofast -mavx2 -mavx512f -mavx512bw -std=c++17 -o $@ $^

run: taxi
	./taxi