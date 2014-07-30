odiobill/timemachine
====================

Plug and Play solution for a **Time Machine** backup server.

This *Debian* based container only run an **afpd** instance, configured to provide a **Time Machine** backup service for any avalable user account.
If you don't need a multi-user setup, then you may just use the pre-defined *timemachine* account (password: *timemachine*), otherwise you just need to add any user you want to the container.

**WARNING:** usually the *ulimits* inherited by the docker container are too low for *netatalk* to run properly. On Debian (or Debian-based) installations, fixing this issue is as simple as adding the following line to */etc/default/docker.io*:

    ulimit -n 65535

Remember to restart the docker service after this modification.

You can execute the container with something like:

    docker run -d -P --name timemachine odiobill/timemachine

