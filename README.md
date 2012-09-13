# Tuleap + Vagrant

This project tries to find a way to get started quickly and easily for
potential Tuleap contributors.


## The simplest way to contribute (cross-plateform)

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


## Customizing, packaging and distributing the tuleap.box file

Clone this repository:

    $ git clone ...
    $ cd tuleap-vagrant/

Get the CentOS 5.8 box template:

    $ vagrant add centos5_8 http://tuleap.net/path/to/centos5_8.box

Boot up a new CentOS instance:

    $ vagrant up

When `vagrant up` is run, it automatically provision the VM using the
tuleap [Chef][3] cookbook.

Now, you can start hacking the chef cookbook to change the way the VM is set
up.

To try the modified cookbook in the VM, run:

    $ vagrant provision

In case you need to restart the VM, run:

    $ vagrant reload

Once you're happy, you can package the new VM:

    $ vagrant package --output ./tuleap.box

Move the new `tuleap.box` to your public server, and you're done.


## Useful documentation

- https://gist.github.com/2178591
- http://wiki.opscode.com/display/chef/Installing+Omnibus+Chef+Client+on+Linux+and+Mac
- http://www.virtualbox.org/manual/ch04.html#idp11962400
- http://www.if-not-true-then-false.com/2010/centos-netinstall-network-installation/
- http://www.if-not-true-then-false.com/2010/install-virtualbox-guest-additions-on-fedora-centos-red-hat-rhel/
- http://vagrantup.com/v1/docs/getting-started/index.html
- http://pyfunc.blogspot.fr/2011/11/creating-base-box-from-scratch-for.html

[1]: http://www.virtualbox.org/
[2]: http://vagrantup.com/
[3]: http://www.opscode.com/chef/

## Creating the initial CentOS 5.8 box

- Download a CentOS 5.8 x86_64 netinstall iso.
- Create a new virtual machine in VirtualBox with 20GB harddisk (building RPM packages can require a lot of space)
- Install the OS
  * Website URL: mirrors.ircam.fr
  * CentOS directory: /pub/CentOS/5.8/os/x86_64/
- Check that VBOX_VERSION in bootstrap.sh matches your VirtualBox version.
- Copy the bootstrap.sh to the VM and run it as root.
- ...
