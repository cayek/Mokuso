import sys
import os
import argparse
import shutil


class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


def main(args=None):
    """The main routine."""
    if args is None:
        args = sys.argv[1:]

    parser = argparse.ArgumentParser(description='Hadjime !!')
    parser.add_argument('--proj', "-p", choices=['labnotebook'],
                        dest="proj", required=True)
    parser.add_argument('--name',
                        "-n", dest="path",
                        help='Path to the new dir project',
                        required=True)

    args = parser.parse_args()

    # hash of project dir
    projname = {'labnotebook': "newLabnotebook", }

    # Get data dir
    this_dir, this_filename = os.path.split(__file__)
    DIR = os.path.join(this_dir, "data", projname[args.proj])
    print DIR

    # test if dir exist
    if os.path.exists(args.path):
        sys.exit(bcolors.FAIL + "Path exists. Please remove " + args.path +
                 " before creating this project." + bcolors.ENDC)

    # copy dir
    shutil.copytree(DIR, args.path)
    print bcolors.OKGREEN + "Hadjime !!" + bcolors.ENDC


if __name__ == "__main__":
    main()
