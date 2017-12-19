# References

* https://www.linux.com/news/containers-vs-hypervisors-choosing-best-virtualization-technology
* https://stackoverflow.com/questions/16047306/how-is-docker-different-from-a-normal-virtual-machine?rq=1
* https://devopscube.com/what-is-docker/
* https://lwn.net/Articles/531114/

# Summary

Linux and FreeBDS kernel implement a kernel level feature called **namespaces**. Global resources are wrapped in namespaces so that they are visible only to processes within the namespace. Processes will not have any privileges outside their own namespace. Namespace supports the implementation of container.

Instead of trying to run a virtual machine, container virtualization isolates the guests, but doesn't try to virtualize the hardware. All instance must share a same kernel though their OS may differ.

