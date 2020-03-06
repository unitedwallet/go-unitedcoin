## Go Unitedcoin

Official Golang implementation of the Unitedcoin protocol.

[![API Reference](
https://camo.githubusercontent.com/915b7be44ada53c290eb157634330494ebe3e30a/68747470733a2f2f676f646f632e6f72672f6769746875622e636f6d2f676f6c616e672f6764646f3f7374617475732e737667
)](https://godoc.org/github.com/youfund/go-unitedcoin)
[![Go Report Card](https://goreportcard.com/badge/github.com/youfund/go-unitedcoin)](https://goreportcard.com/report/github.com/youfund/go-unitedcoin)
[![Travis](https://travis-ci.org/youfund/go-unitedcoin.svg?branch=master)](https://travis-ci.org/youfund/go-unitedcoin)
[![Discord](https://img.shields.io/badge/discord-join%20chat-blue.svg)](https://discord.gg/nthXNEv)

Automated builds are available for stable releases and the unstable master branch. Binary
archives are published at https://gun.youfund.org/unitedcoin/downloads/.

## Building the source

For prerequisites and detailed build instructions please read the [Installation Instructions](https://github.com/youfund/go-unitedcoin/wiki/Building-Unitedcoin) on the wiki.

Building `gun` requires both a Go (version 1.10 or later) and a C compiler. You can install
them using your favourite package manager. Once the dependencies are installed, run

```shell
make gun
```

or, to build the full suite of utilities:

```shell
make all
```

## Project

It is developed on the basis of Ethereum, bitcoin and other blockchain technologies. It is mainly commit to providing cross chain technology and high transaction concurrency.

Support a block to wrap tens of thousands of transactions, one transaction can complete up to more than 100000 token transfer capacity.


## License

The go-unitedcoin library (i.e. all code outside of the `cmd` directory) is licensed under the
[GNU Lesser General Public License v3.0](https://www.gnu.org/licenses/lgpl-3.0.en.html),
also included in our repository in the `COPYING.LESSER` file.

The go-unitedcoin binaries (i.e. all code inside of the `cmd` directory) is licensed under the
[GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html), also
included in our repository in the `COPYING` file.
