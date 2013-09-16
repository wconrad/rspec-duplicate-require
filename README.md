**NOTE**: The alleged bug that this project demonstrates turns out to
be just the way Ruby works.  It's got nothing to do with rspec.
Please see this discussion for more explanation:

* https://github.com/rspec/rspec-core/issues/1076

Thanks to Myron Marston for his patient explanation.

-----

This short project illustrates a problem I've encountered with rspec.

Ruby is disinclined to require the same file twice; our tests depend
on this to keep a spec_helper from being loaded more than once.  I've
found an odd circumstance that cause rspec to load spec_helper more
than once:

* One spec uses `File.expand_path` to require *spec_helper*
* Another spec uses `require_relative` to require *spec_helper*
* rspec is given a fully qualified path which includes a symlink to
  the directory containing the specs Under this odd (but not
  contrived) circumstance, the spec_helper will be loaded more than
  once.

To reproduce:

    $./test.sh

The output:

    Ruby, symlinked directory:
      foo_spec
        spec_helper
      bar_spec
    Rspec, real directory:
      foo_spec
        spec_helper
      bar_spec
    Rspec, symlinked directory:
      bar_spec
        spec_helper
      foo_spec
        spec_helper     <- Should not have been loaded
