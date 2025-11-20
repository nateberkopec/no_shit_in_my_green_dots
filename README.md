# NoShitInMyGreenDots

Are you sick of this?

```
Run options: --seed 12345

# Running:

.D, [2025-01-20T10:23:45.123456 #12345] DEBUG -- : Redis connected to localhost:6379
.I, [2025-01-20T10:23:45.234567 #12345]  INFO -- : Processing user #1234
.[ActiveJob] Enqueued EmailJob (Job ID: abc-123) to Sidekiq(default)
.HTTP Request: GET /api/users
..D, [2025-01-20T10:23:45.345678 #12345] DEBUG -- : Cache miss for key: user_1234
.[Rack::Handler::WEBrick] 127.0.0.1 - - [20/Jan/2025:10:23:45 EST] "GET /health HTTP/1.1" 200
I, [2025-01-20T10:23:45.456789 #12345]  INFO -- : Background job completed in 0.05s
..

Finished in 0.012345s, 810.0 runs/s, 810.0 assertions/s.

10 runs, 10 assertions, 0 failures, 0 errors, 0 skips
```

Now, you can enforce your overly fastidious notions of clean test output on your friends and co-workers!

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
