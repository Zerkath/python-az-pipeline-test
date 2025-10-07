# Testing Azure Pipeline

*uv* already provides some benchmarking but this is for a more high resource system than the typical pipeline.

[uv Benchamrk](https://github.com/astral-sh/uv/blob/main/BENCHMARKS.md)

This solution is mainly meant to see how big the difference is in the typical pipeline job.

Intention to test Azure Pipelines first as this is what I use professionally.

Local naive benchmark between the docker builds, on a high performance system.
UV shows high promise in being very optimized for a cold run.

> CPU: 12-core AMD Ryzen 9 5900X (-MT MCP-) speed/min/max: 1731/567/4955 MHz
> Kernel: 6.16.10-arch1-1 x86_64 Up: 1h 13m Mem: 6.32/31.24 GiB (20.2%)
> 590/550 down/up mbps

```
hyperfine --warmup 5 "docker build -f uv.Dockerfile --no-cache --network=host ." "docker build -f poetry.Dockerfile --no-cache --network=host ."
Benchmark 1: docker build -f uv.Dockerfile --no-cache --network=host .
  Time (mean ± σ):      5.999 s ±  0.002 s    [User: 0.015 s, System: 0.009 s]
  Range (min … max):    5.996 s …  6.004 s    10 runs

Benchmark 2: docker build -f poetry.Dockerfile --no-cache --network=host .
  Time (mean ± σ):     17.499 s ±  1.581 s    [User: 0.017 s, System: 0.015 s]
  Range (min … max):   16.995 s … 21.999 s    10 runs

  Warning: Statistical outliers were detected. Consider re-running this benchmark on a quiet system without any interferences from other programs. It might help to use the '--warmup' or '--prepare' options.

Summary
  docker build -f uv.Dockerfile --no-cache --network=host . ran
    2.92 ± 0.26 times faster than docker build -f poetry.Dockerfile --no-cache --network=host .
```

Basic sync task.
```
hyperfine --warmup 5 "uv sync" "poetry sync"
Benchmark 1: uv sync
  Time (mean ± σ):       8.9 ms ±   0.4 ms    [User: 3.9 ms, System: 5.0 ms]
  Range (min … max):     7.9 ms …  10.1 ms    301 runs

Benchmark 2: poetry sync
  Time (mean ± σ):     497.8 ms ±   3.4 ms    [User: 420.8 ms, System: 75.4 ms]
  Range (min … max):   490.0 ms … 501.9 ms    10 runs

Summary
  uv sync ran
   55.80 ± 2.38 times faster than poetry sync
```


- [uv](https://docs.astral.sh/uv/)
- [poetry](https://python-poetry.org/)
