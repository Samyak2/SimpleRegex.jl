# SimpleRegex.jl

A very simple Regular Expression based string matching implementation in Julia.

You probably do not want to use this in real applications, Julia has a better (and probably faster) inbuilt regular expression implementation. This was made only for testing and fun.

The implementation is similar to the JavaScript version from [this blog post](https://nickdrane.com/build-your-own-regex/). Inspired by  [Kriyszig's implementation](https://github.com/Kriyszig/regex).

# Features

 - A small subset of Regex syntax
 - Supported special characters: `$`, `^`, `.`, `?`, `*`
 - Can be quite slow for longer text (since it uses simple backtracking based recursive algorithms)

# Requirements

Tested on Julia 1.3.0

No additional packages required.

# Benchmark Results

```Julia
julia> @btime search($randstring(10), $randstring(100))
  17.345 μs (605 allocations: 23.34 KiB)
false

julia> @btime search($randstring(100), $randstring(100))
  57.693 μs (605 allocations: 33.09 KiB)
false

julia> @btime search($randstring(100), $randstring(1000))
  591.240 μs (6021 allocations: 783.61 KiB)
false

julia> @btime search($randstring(1000), $randstring(10000))
  58.451 ms (60577 allocations: 61.01 MiB)
false

julia> @btime search($randstring(100), $randstring(10000))
  13.461 ms (60529 allocations: 51.71 MiB)
false

julia> @btime search($randstring(10), $randstring(10000))
  9.901 ms (60518 allocations: 50.75 MiB)
false

julia> @btime search($randstring(1), $randstring(10000))
  8.225 ms (30008 allocations: 49.23 MiB)
```

