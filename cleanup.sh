#!/usr/bin/env bash

test_name="$1"

pkill -9 containerd

for f in "$( sudo grep $test_name /proc/self/mountinfo )"; do
	umount "$( echo "$f" | awk '{print $5}' )"
done

find /sys/fs/cgroup -name "$test_name" | xargs rmdir

rm -rf /run/containerd/runc/testing/$test_name
rm -rf /run/containerd-test/io.containerd.runtime.v1.linux/testing/$test_name
