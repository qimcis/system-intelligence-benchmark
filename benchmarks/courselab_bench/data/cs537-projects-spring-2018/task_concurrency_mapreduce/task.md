# CS537 Spring 2018 Project 4a: MapReduce

In this lab you will implement a simplified, single-machine MapReduce library using threads. Your job is to implement the MapReduce runtime in `mapreduce.c` so that user programs can call:

- `MR_Emit(char *key, char *value)`
- `MR_DefaultHashPartition(char *key, int num_partitions)`
- `MR_Run(int argc, char *argv[], Mapper map, int num_mappers, Reducer reduce, int num_reducers, Partitioner partition)`

## What to do

1. Read the full project description in:
   `/workspace/ostep-projects/concurrency-mapreduce/README.md`
2. Implement the MapReduce library in:
   `/workspace/ostep-projects/concurrency-mapreduce/mapreduce.c`

## Notes

- Your library will be compiled with `-Wall -Werror -pthread -O2`.
- The evaluator runs two correctness tests that compile your `mapreduce.c` with small MapReduce applications and compare the output.
- Make sure `MR_Emit()` makes its own copies of keys and values (stack-allocated strings must remain valid after the call).

When you're done, the tests should pass without modifying any of the provided test inputs or harness files.
