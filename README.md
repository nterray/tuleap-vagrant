# Tuleap + Vagrant

Provides an easy way to get started with Tuleap development, packaging and
deployment.

## Setting up the environment

First, download and install [VirtualBox][1] and [Vagrant][2].

We assume you have the following layout, where `my-tuleap-workspace` can be
whatever you want:

    my-tuleap-workspace
    ├── manifest
    ├── tuleap
    └── vagrant

The `manifest` repository is only needed for Tuleap packaging.

So lets clone the `vagrant` repository into `my-tuleap-workspace`:

    $ cd my-tuleap-workspace/
    $ git clone gitolite@tuleap.net:tuleap/tools/vagrant.git
    $ cd vagrant/
    $ git submodule init
    $ git submodule update

**Optionally**, get the CentOS 5.8 box template, so that you can create as
many boxes you want (if you don't, `vagrant` will download it for you when
started):

    $ vagrant add centos-5.8-x86_64-chef http://192.168.1.222/~sebn/centos-5.8-x86_64-chef.box

Edit the `Vagrantfile` to match your needs.

Finally, start the box:

    $ vagrant up

When `vagrant up` is run, it will automatically provision the VM using the
tuleap [Chef][3] cookbook.

Most useful commands are `vagrant {up [--no-provision]|provision|halt|suspend|resume|ssh}`.
See `vagrant help` for more info.

## Known issues

- You need to run `vagrant provision` twice (first time will add root to group
  `mock` and fail, second time will work).
- Some `yum clean` commands are hardcoded in `script` resources (extract to
  definition ?).
- There are no i386 / centos6 / debian boxes yet.

## Possible future

Ideally, the tuleap repository should contain the following `Vagrantfile`:

    Vagrant::Config.run do |config|
      config.vm.box     = 'tuleap'
      config.vm.box_url = 'http://tuleap.net/path/to/tuleap.box'
    end

Then, people willing to contribute would just have to download and install
[VirtualBox][1], [Vagrant][2], and set up a new Tuleap instance:

    $ vagrant up
    
And voilà, no need to configure VirtualBox, no useless VM window, no
CentOS install, no tuleap deployment, everything just works.

## How was the initial box created ?

- Download a CentOS 5.8 x86_64 netinstall iso.
- Create a new virtual machine in VirtualBox, named `CentOS-5.8-x86_64-chef`
  * Set 20GB for harddisk size, dynamically allocated (building RPM packages can require a lot of space)
  * Use the default network settings: NAT (you may need to forward your SSH port for `vagrant package` to work)
- Install the OS
  * Website URL: `mirrors.ircam.fr`
  * CentOS directory: `/pub/CentOS/5.8/os/x86_64/`
- Check that `VBOX_VERSION` in `bootstrap.sh` matches your VirtualBox version.
- Copy the `bootstrap.sh` to the VM and run it as root.
- Manually comment the "Default requiretty" line in /etc/sudoers

- Finally, assuming your VBox VM name is "CentOS-5.8-x86_64-chef", run:
  `vagrant package --base CentOS-5.8-x86_64-chef --output centos-5.8-x86_64-chef.box`
- In case vagrant messes up with SSH port, try using NAT + forwarding port 22
  in VirtualBox Configuration.
- Now you can make `centos-5.8-x86_64-chef.box` available on some web server,
  and use it to build `tuleap.box`

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
