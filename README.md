# pgtap-demo

### Build docker image

```sh
docker build -t postgres-pgtap .
```

### Start docker container

```sh
docker-compose up -d --force-recreate
```

### Execute a bash shell

```sh
docker exec -it pgtap bash
su - postgres
```

### Run tests

```sh
pg_prove -d postgres /tests
```

```sh
18d7ae4838e3:~$ pg_prove -d postgres /tests
/tests/proc_check_deps_1.pg ...... ok
/tests/proc_check_divs_1.pg ...... ok
/tests/proc_complete_users_1.pg .. ok
/tests/proc_split_deps_1.pg ...... ok
/tests/proc_split_divs_1.pg ...... ok
/tests/proc_split_tels_1.pg ...... ok
/tests/proc_split_users_1.pg ..... ok
All tests successful.
Files=7, Tests=7,  0 wallclock secs ( 0.05 usr  0.02 sys +  0.01 cusr  0.02 csys =  0.10 CPU)
Result: PASS
```
