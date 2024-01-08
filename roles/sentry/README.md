## Sentry Role

We run a self-hosted version of sentry(https://sentry.io), deployed using their
self hosting instructions:

https://develop.sentry.dev/self-hosted/

The best way to deploy the service is to follow the instructions in that link,
since it boils down to downloading and running an install script.  This installation can take a long time (> 30 minutes) and so running it via ansible is not ideal.  While we created a role for this originally, there was too much 
trickery we had to do to keep our ssh connection open and running while sentry's own script did its job.  We do not want arbitrary ansible issues to interfere with their recommended install path, and so we opted to not use ansible for this.

Following sentry's advice, for our current deployment we have the docker services behind an nginx proxy running on the server, with the TLS handled by the proxy.  The server is also generally hardened 

## Metrics

We do want to keep metrics about the server itself and whether sentry is healthy
and htis can be handled by ansible. We collect these metrics using
node-exporter, extending the base exporter with a cusotm check that uses
sentry's own `/_health` endpoint. So this role now serves to create and add that
custom extension.

For the curious, you can still check out the tasks section of this role, and the bottom commented out section, to see the steps you'd take to install sentry...but again, these steps should be taken on the server itself, and not via ansible.


