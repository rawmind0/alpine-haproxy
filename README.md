alpine-haproxy 
==============

This image is the haproxy base. It comes from [alpine-monit][alpine-monit].

## Build

```
docker build -t rawmind/alpine-haproxy:<version> .
```

## Versions

- `1.6.7-3` [(Dockerfile)](https://github.com/rawmind0/alpine-haproxy/blob/1.6.7-3/Dockerfile)


## Configuration

This image runs [haproxy][haproxy] with monit. It is started with haproxy user/group with 10007 uid/gid.

As service is running as non provileged user, your can't listen in a privileged ports. if you need privileged ports redirect them from host or set them at k8s service.

Monit is healthchecking service throught port 8000, used to serve haproxy stats in the basic config. If you add a custom haproxy.cfg, don't remove listen stats at port 8000. 

### Custom Configuration

Haproxy is installed under /opt/haproxy and make use of /opt/haproxy/etc/haproxy.cfg as config file.

You can edit or overwrite this files in order to customize your own configuration or certificates.

You could also include FROM rawmind/alpine-haproxy at the top of your Dockerfile, and add your custom config.


### SSL Configuration

SSL certificates are located by default in /opt/haproxy/etc/ssl. 

You could also include FROM rawmind/alpine-haproxy at the top of your Dockerfile, and add your custom ssl files.


[alpine-monit]: https://github.com/rawmind0/alpine-monit/
[haproxy]: http://www.haproxy.org/

