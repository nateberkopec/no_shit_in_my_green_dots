# NoShitInMyGreenDots

Keep your dots green and quiet. This gem fails any test that writes to `STDOUT`, while leaving your test runner's own reporter output alone.

```
Run options: --seed 12345

# Running:

....F.....

Finished in 0.012345s, 810.0 runs/s, 810.0 assertions/s.

  1) STDOUT:
NoisyTest#test_logs [test/noisy_test.rb:6]:
Test wrote to STDOUT:
---
direct write
I, [2025-01-01T12:34:56.789012 #1234]  INFO -- : logger write
child_output
---

10 runs, 10 assertions, 1 failures, 0 errors, 0 skips
```

## Installation

Add the gem to your bundle:

```ruby
group :test do
  gem "no_shit_in_my_green_dots"
end
```

## How it works

For each example/test, STDOUT is redirected to a pipe. If anything other than the test framework's reporter writes to STDOUT during that example/test, the example/test fails with a short dump of the captured output (truncated for very noisy cases). Only suite-wide enablement is supported; per-example toggles are intentionally not provided. STDERR is left alone, and IO objects that were duped from STDOUT *before* enabling the gem may not be caught—point long-lived loggers at `STDOUT`/`$stdout` after enabling if you need them guarded.
