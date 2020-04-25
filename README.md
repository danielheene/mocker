# dnsdrone/mocker

> creates a mocked docker environment with persistent and dynamic containers for testing issues

## Usage

__Seeder:__

To create a mocked docker environment run `dnsdrone/mocker` as seeder by using the `seed` command.
The seeder instance will create the defined amount of persistent containers which will idle infinitely
and the defined amount of dynamic containers which will kill themselves by a random time between the
minimum and maximum lifespan value.

*(when a dynamic containers maximum lifespan is reached it will kill itself and the seeder creates a
new one with a random idle time to keep up to the defined amount of containers)*

```bash
docker run --rm -ti \
  -v "/var/run/docker.sock:/var/run/docker.sock" \
  -e "SPAWN_PERSISTENT=<number>" \
  -e "SPAWN_DYNAMIC=<number>" \
  -e "SPAWN_MIN_LIFESPAN=<number>" \
  -e "SPAWN_MAX_LIFESPAN=<number>" \
  -e "MOCKED_LABELS_GLOB=<string>" \
  --name "dnsdrone-seeder" \
  dnsdrone/mocker \
  seed
```

__Idler:__

You can also create idling instances directly and skip the automatic seeder by running the container
with the `idle` command to keep an infinite idling container.

*(optionally you can add an integer value as a parameter for a desired amount of minutes -
for instance `idle 3` for creating a container that will kill itself after three minutes)*

```bash
docker run --rm -ti \
  -v "/var/run/docker.sock:/var/run/docker.sock" \
  --name "dnsdrone-idler" \
  dnsdrone/mocker \
  idle [int minutes]
```

#### Environment Variables (for seeder)

|        name        | default |              description                |
|--------------------|---------|-----------------------------------------|
| SPAWN_PERSISTENT   |   10    | amount of persistent idle containers    |
| SPAWN_DYNAMIC      |   15    | amount of dynamic idle containers       |
| SPAWN_MIN_LIFESPAN |    5    | minimum idle time of dynamic containers |
| SPAWN_MAX_LIFESPAN |   10    | maximum idle time of dynamic containers |
| MOCKED_LABELS_GLOB |    *    | pattern for picking random label files  |

#### Contribution / Example / Running Local

You can find an example use case in [`test_local.sh`](https://github.com/dnsdrone/mocker/blob/master/test_local.sh).

----

#### License
[MIT](https://github.com/dnsdrone/mocker/blob/master/LICENSE)
