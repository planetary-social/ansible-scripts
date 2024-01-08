# image-update-service

A small role for use with docker deployments. It will create a set of files for
continuously polling our container registry and updating the service if there's
a new version of the chosen tag.

## Vars

| variable          | description                                      | example                                    |
|-------------------|--------------------------------------------------|--------------------------------------------|
| service_name      | name of service, will be prepended to our files  | nos-event                                  |
| service_image     | docker image of service                          | ghcr.io/planetary-social/nos-event-service |
| service_image_tag | the tag of deployed service, what we will update | latest                                     |
| frequency         | how often to poll container registry             | 3m                                         |
| working_dir       | location of service docker_compose               | /home/admin/services/events                |


