
# Copyright (c) 2005-2010, 2012-2013, Andrew Hang Chen and contributors,
# All rights reserved.
# Licensed under the 3-clause BSD license.

module RakeBase
  puts "RUBY_PLATFORM=" + RUBY_PLATFORM if $show_info

  if RUBY_PLATFORM =~ /linux/i or 
     RUBY_PLATFORM =~ /cygwin/i or 
     RUBY_PLATFORM =~/darwin/i

    # gfortran + Open MPI on Linux
    $compiler = 'mpif90'
    $option = "-Wall -Wextra -pedantic -fbounds-check " +
              "-Wuninitialized -O -g -Wno-unused-parameter -cpp "
    $ext_obj = "o"
    $dosish_path = false
    $gcov = "-coverage"
    $prof_genx = false
  else
    print "RUBY_PLATFORM = ", RUBY_PLATFORM, "\n"
    raise "Only Linux + Open MPI tested"
  end

  #---------------------------------------------------
  #`where ...` works on windows vista, 7 and 8. Not works on Windows XP.
  test_where = `where where 2>&1`
  if $?.to_i == 0
    where_or_which = "where"
  else
    where_or_which = "which"
  end

  #---------------------------------------------------

  $linker = $compiler if !$linker
  $linker_option = $option if !$linker_option
  $option_obj = " -c -o " if !$option_obj
  $ext_obj    = "o"       if !$ext_obj
  $option_exe = " -o "    if !$option_exe

  result_which = `which ar 2>&1`
  $ar_ok = false
  $ar_ok = true if $?.to_i == 0
  $ar_ok = false if $compiler == "ftn95"
end
