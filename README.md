series(1) -- generate series data
=============================================

## SYNOPSIS

`series` [options] SERIES_COMMAND ARGS...
`series` [options] -M 'SERIES_COMMAND ARGS' ...

## DESCRIPTION

**series** generates series data by passing a series index to a command that translates that index to one or more values.  Multiple series can be generated at the same time.  Common series are included by default, additional commands can be added by putting them on PATH.

## OPTIONS

These options control how `series` operates:

* `-F`, `--field-sep SEP`:
  Set the output field separator (" ").

* `--full-csv-parser`:
  Use a full csv parser instead of the minimal parser when handling multi-value outputs from commands.

* `-L`, `--line-sep SEP`:
  Set the output line separator ("\n").

* `-l`, `--list`:
  List available series commands.

* `-h`, `--help`:
  Print this help.

* `-i`, `--[no-]step-index`:
  Print step index with each output.

* `-M`, `--multi-series`:
  Generate multiple series. With this option arguments are treated as an array of `COMMAND ARGS...` strings that get executed in parallel.

* `-m`, `--stream`:
  Generate steps indefinitely.  Output stops when the any series comes to an end.

* `-n`, `--n-steps NUM`:
  Set the number of steps in series (8).

* `-o`, `--offset NUM`:
  Set the step offset (0).

* `-r`, `--round NUM`:
  Round outputs to precision.

* `-s`, `--step-size NUM`:
  Set the step size (1).

* `-u`, `--[no-]unbuffer`:
  Unbuffer output

## EXAMPLES

Generate a linear series:

  series linear 1 2
  # 2.0
  # 3.0
  # 4.0
  # ...

Generate a series rounding and limiting steps:

  series -n 3 -r 0 linear 1 2
  # 2
  # 3
  # 4

Generate multiple series:

  series -n 3 -r 0 -M 'linear 1 2' 'geometric' 'fibonacci'
  # 2 1 0
  # 3 2 1
  # 4 4 1

Series commands can be passed options, just be sure to stop option parsing for the `series` driver.

  series -- linear -h
  # usage: series-linear [options] [M=1.0] [B=0.0]
  # ...

## CREATING SERIES COMMANDS

Series commands read the current series index from stdin and write series values to stdout.  If multiple output values are generated then the output values must be printed as CSV (see below).  Series commands follow the naming convention `series-COMMAND_NAME`, must be executable, and available on PATH.

  cat > series-add-ten <<DOC
  #!/usr/bin/env ruby
  while line = gets
    index = Integer(line.chomp("\n"))
    puts index + 10
  end
  DOC
  chmod +x series-add-ten

  PATH="$PWD:$PATH" series -i -r0 -n3 add-ten
  # 0 10
  # 1 11
  # 2 20

Note that typically series commands generate numeric outputs and so the driver uses a minimal CSV parser that only splits on "," without checking for escape sequences, line continuations, etc.  If you need a full CSV parser then use the `--full-csv-parser` option.

## COPYRIGHT

series is Copyright (C) 2014 Simon Chiang <http://github.com/thinkerbot>
