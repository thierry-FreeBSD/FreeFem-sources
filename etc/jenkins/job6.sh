#!/bin/sh

## This job must be executed on VM2 machines
## See ./README.md

## Nightly launched

echo "Job 6"

# configuration & build
autoreconf -i \
  && ./configure  --enable-download --enable-debug --prefix=/builds/workspace/freefem \
  && ./3rdparty/getall -a \
  && chmod +x ./etc/jenkins/blob/build_PETSc.sh && sh ./etc/jenkins/blob/build_PETSc.sh \
  && chmod +x ./etc/jenkins/blob/build.sh && sh ./etc/jenkins/blob/build.sh

if [ $? -eq 0 ]
then
  echo "Build process complete"
else
  echo "Build process failed"
  exit 1
fi

# check
chmod +x ./etc/jenkins/blob/check.sh && sh ./etc/jenkins/blob/check.sh

if [ $? -eq 0 ]
then
  echo "Check process complete"
else
  echo "Check process failed"
fi

# install
chmod +x ./etc/jenkins/blob/install.sh && sh ./etc/jenkins/blob/install.sh

if [ $? -eq 0 ]
then
  echo "Install process complete"
else
  echo "Install process failed"
fi
