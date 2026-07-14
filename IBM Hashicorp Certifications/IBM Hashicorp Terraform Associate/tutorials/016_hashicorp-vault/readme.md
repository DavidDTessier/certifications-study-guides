vault server -dev -dev-root-token-id="education"
==> Vault server configuration:

             Api Address: http://127.0.0.1:8200
                     Cgo: disabled
         Cluster Address: https://127.0.0.1:8201
              Go Version: go1.17.5
              Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "127.0.0.1:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: info
                   Mlock: supported: false, enabled: false
           Recovery Mode: false
                 Storage: inmem
                 Version: Vault v1.9.3
             Version Sha: 7dbdd57243a0d8d9d9e07cd01eb657369f8e1b8a

==> Vault server started! Log data will stream in below:

2022-02-03T08:01:19.492-0500 [INFO]  proxy environment: http_proxy="\"\"" https_proxy="\"\"" no_proxy="\"\""
2022-02-03T08:01:19.492-0500 [WARN]  no `api_addr` value specified in config or in VAULT_API_ADDR; falling back to detection if possible, but this value should be manually set
2022-02-03T08:01:19.493-0500 [INFO]  core: Initializing VersionTimestamps for core
2022-02-03T08:01:19.494-0500 [INFO]  core: security barrier not initialized
2022-02-03T08:01:19.494-0500 [INFO]  core: security barrier initialized: stored=1 shares=1 threshold=1
2022-02-03T08:01:19.494-0500 [INFO]  core: post-unseal setup starting
2022-02-03T08:01:19.497-0500 [INFO]  core: loaded wrapping token key
2022-02-03T08:01:19.497-0500 [INFO]  core: Recorded vault version: vault version=1.9.3 upgrade time="2022-02-03 08:01:19.497602 -0500 EST m=+0.053319167"
2022-02-03T08:01:19.497-0500 [INFO]  core: successfully setup plugin catalog: plugin-directory="\"\""
2022-02-03T08:01:19.497-0500 [INFO]  core: no mounts; adding default mount table
2022-02-03T08:01:19.498-0500 [INFO]  core: successfully mounted backend: type=cubbyhole path=cubbyhole/
2022-02-03T08:01:19.499-0500 [INFO]  core: successfully mounted backend: type=system path=sys/
2022-02-03T08:01:19.499-0500 [INFO]  core: successfully mounted backend: type=identity path=identity/
2022-02-03T08:01:19.501-0500 [INFO]  core: successfully enabled credential backend: type=token path=token/
2022-02-03T08:01:19.501-0500 [INFO]  rollback: starting rollback manager
2022-02-03T08:01:19.501-0500 [INFO]  core: restoring leases
2022-02-03T08:01:19.503-0500 [INFO]  identity: entities restored
2022-02-03T08:01:19.503-0500 [INFO]  identity: groups restored
2022-02-03T08:01:19.503-0500 [INFO]  expiration: lease restore complete
2022-02-03T08:01:19.503-0500 [INFO]  core: post-unseal setup complete
2022-02-03T08:01:19.504-0500 [INFO]  core: root token generated
2022-02-03T08:01:19.504-0500 [INFO]  core: pre-seal teardown starting
2022-02-03T08:01:19.504-0500 [INFO]  rollback: stopping rollback manager
2022-02-03T08:01:19.505-0500 [INFO]  core: pre-seal teardown complete
2022-02-03T08:01:19.505-0500 [INFO]  core.cluster-listener.tcp: starting listener: listener_address=127.0.0.1:8201
2022-02-03T08:01:19.505-0500 [INFO]  core.cluster-listener: serving cluster requests: cluster_listen_address=127.0.0.1:8201
2022-02-03T08:01:19.506-0500 [INFO]  core: post-unseal setup starting
2022-02-03T08:01:19.506-0500 [INFO]  core: loaded wrapping token key
2022-02-03T08:01:19.506-0500 [INFO]  core: successfully setup plugin catalog: plugin-directory="\"\""
2022-02-03T08:01:19.506-0500 [INFO]  core: successfully mounted backend: type=system path=sys/
2022-02-03T08:01:19.506-0500 [INFO]  core: successfully mounted backend: type=identity path=identity/
2022-02-03T08:01:19.506-0500 [INFO]  core: successfully mounted backend: type=cubbyhole path=cubbyhole/
2022-02-03T08:01:19.507-0500 [INFO]  core: successfully enabled credential backend: type=token path=token/
2022-02-03T08:01:19.507-0500 [INFO]  rollback: starting rollback manager
2022-02-03T08:01:19.508-0500 [INFO]  core: restoring leases
2022-02-03T08:01:19.508-0500 [INFO]  identity: entities restored
2022-02-03T08:01:19.508-0500 [INFO]  identity: groups restored
2022-02-03T08:01:19.508-0500 [INFO]  core: post-unseal setup complete
2022-02-03T08:01:19.508-0500 [INFO]  expiration: lease restore complete
2022-02-03T08:01:19.508-0500 [INFO]  core: vault is unsealed
2022-02-03T08:01:19.511-0500 [INFO]  expiration: revoked lease: lease_id=auth/token/root/hd812e4cdcf9bd3f9fade23e03c0288dd179bcac22f58f77399de937d9221b202
2022-02-03T08:01:19.514-0500 [INFO]  core: successful mount: namespace="\"\"" path=secret/ type=kv
2022-02-03T08:01:19.524-0500 [INFO]  secrets.kv.kv_3fe9d86c: collecting keys to upgrade
2022-02-03T08:01:19.524-0500 [INFO]  secrets.kv.kv_3fe9d86c: done collecting keys: num_keys=1
2022-02-03T08:01:19.524-0500 [INFO]  secrets.kv.kv_3fe9d86c: upgrading keys finished
WARNING! dev mode is enabled! In this mode, Vault runs entirely in-memory
and starts unsealed with a single unseal key. The root token is already
authenticated to the CLI, so you can immediately begin using Vault.

You may need to set the following environment variable:

    $ export VAULT_ADDR='http://127.0.0.1:8200'

The unseal key and root token are displayed below in case you want to
seal/unseal the Vault or re-authenticate.

Unseal Key: r5EneJM+zsdml8paYSdGSvMSHuOoIZihZRyFGkemnAA=
Root Token: education

Development mode should NOT be used in production installations!


---- 

commands

get multi-key secret
% vault kv get -field={field_name} {vault}/{path}