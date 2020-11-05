## The Arm Research Starter Kit: System Modeling using gem5

This Research Starter Kit will guide you through Arm-based system modeling using the gem5 simulator and a 64-bit CPU model. This High-Performance In-order (HPI) CPU model is tuned to be representative of a modern in-order Armv8-A implementation.

You can find more information about the Arm Research Enablement Kits at: [https://developer.arm.com/solutions/research/research-enablement-kits](https://developer.arm.com/solutions/research/research-enablement-kits)

This Research Starter Kit is comprised of two main parts:

1. **[gem5](https://gem5.googlesource.com/public/gem5)**: the source code for the [gem5 simulator](https://www.gem5.org/) 
2. **[arm-gem5-rsk](https://github.com/arm-university/arm-gem5-rsk.git)**: the current repository, which contains the scripts, patches and the documentation required to get started, and also run examples and benchmarks 

Either clone the above repositories separately, or use the [clone.sh](https://raw.githubusercontent.com/arm-university/arm-gem5-rsk/master/clone.sh) script to clone both of them:
```bash
$ wget https://raw.githubusercontent.com/arm-university/arm-gem5-rsk/master/clone.sh
$ bash clone.sh
```

The current release includes the following components:
* **gem5_rsk.pdf**: the documentation
* **clone.sh**: a script to download all the required materials
* **read_results.sh**: a script to read the gem5 statistics
* **parsec_patches**: contains patches for compiling PARSEC for the gem5 Full-System simulation mode
* **parsec_rcs**: contains a script for creating runscripts for PARSEC benchmarks
* [Wiki](https://github.com/arm-university/arm-gem5-rsk/wiki): a cheat sheet, containing all code and examples provided in the documentation
