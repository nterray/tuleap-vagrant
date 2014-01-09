# Tuleap + Vagrant

Provides an easy way to get started with Tuleap development, packaging and
deployment.

## Setting up the environment

First, download and install [VirtualBox][1] and [Vagrant][2].

We assume you have the following layout, where `my-tuleap-workspace` can be
whatever you want:

    my-tuleap-workspace
    ├── tuleap
    └── vagrant


So lets clone the `vagrant` repository into `my-tuleap-workspace`:

    $ cd my-tuleap-workspace/
    $ git clone gitolite@tuleap.net:tuleap/tools/vagrant.git
    $ cd vagrant/
    $ git submodule init
    $ git submodule update

    $ vagrant up

When `vagrant up` is run, it will automatically provision the VM using the
tuleap [Chef][3] cookbook.

Most useful commands are `vagrant {up [--no-provision]|provision|halt|suspend|resume|ssh}`.
See `vagrant help` for more info.

## How was the initial box created ?

It was created with automated script at https://tuleap.net/plugins/git/index.php/101/view/156/

## Useful documentation

- https://gist.github.com/2178591
- http://wiki.opscode.com/display/chef/Installing+Omnibus+Chef+Client+on+Linux+and+Mac
- http://www.virtualbox.org/manual/ch04.html#idp11962400
- http://www.if-not-true-then-false.com/2010/centos-netinstall-network-installation/
- http://www.if-not-true-then-false.com/2010/install-virtualbox-guest-additions-on-fedora-centos-red-hat-rhel/
- http://vagrantup.com/v1/docs/getting-started/index.html
- http://pyfunc.blogspot.fr/2011/11/creating-base-box-from-scratch-for.html
- http://www.yodi.me/blog/2011/10/26/build-base-box-vagrant-ubuntu-oneiric-11.10-server/

[1]: http://www.virtualbox.org/
[2]: http://vagrantup.com/
[3]: http://www.opscode.com/chef/
