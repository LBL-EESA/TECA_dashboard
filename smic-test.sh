#!/bin/bash -l
if [[ $# != 2 ]]
then
    echo
    echo "ERROR: Usage"
    echo "$0 Experimental|Nightly|Continuous asan|basic"
    echo
    exit -1
fi
DASHROOT=/work/dashboards/teca
cd $DASHROOT
case "$1" in
    Experimental)
      ;;
    Nightly)
      ;;
    Continuous)
      ;;
    *)
      echo "ERROR: bad config \$1=$1 is invalid."
      exit -1
esac
case "$2" in
    basic)
      DASHCONFIG=smic-config.cmake
      ;;
    asan)
      DASHCONFIG=smic-config-asan.cmake
      export ASAN_SYMBOLIZER_PATH=`which llvm-symbolizer`
      export ASAN_OPTIONS=symbolize=1
      ;;
    *)
      echo "ERROR: bad config \$2=$2 is invalid."
      exit -1
esac

source $DASHROOT/teca-deps/bin/teca_env.sh
export PATH=.:$PATH
export LD_LIBRARY_PATH=$DASHROOT/$1/build/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$DASHROOT/$1/build/lib:$PYTHONPATH
export DASHBOARD_TYPE=$1
LOCKFILE=lock_$DASHBOARD_TYPE
if [[ -e $LOCKFILE ]]
then
    echo
    echo "ERROR: Found lockfile $LOCKFILE"
    echo "ERROR: Won't start another run while one is already running"
    echo
    exit -2
fi
touch $LOCKFILE
trap "rm -f $LOCKFILE; exit" SIGHUP SIGINT SIGTERM
EPOCH=`date +%s`
ctest --timeout 300 -S ${DASHROOT}/${DASHCONFIG} -O ./logs/$DASHBOARD_TYPE-$EPOCH.log -V
find ${DASHROOT}/logs -maxdepth 0 -name '*.log' -atime 2 -exec rm \{\} \;
rm $LOCKFILE
