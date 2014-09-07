#!/bin/bash

sed 's/lxc.hook.clone/#lxc_hook_clone/g' fedora.common.conf.in > fedora.common.conf
