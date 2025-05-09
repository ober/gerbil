# Actors

Actor-oriented concurrent and distributed programming.

::: tip to use bindings from this package
(import :std/actor)
:::

::: tip Note
This page documents the API of the actors package in Gerbil v0.18 and later; the legacy actor package is deprecated, but still available in `:std/actor-v13` if you need time to port existing code.
:::

## Messaging Primitives

### ->
```scheme
(-> dest msg
    replyto: (replyto #f)
    expiry: (expiry #f)
    reply-expected: (reply-expected? #f))
```
Sends a message to `dest`, which must be a thread or actor handle, wrapped in an envelope.
- `replyto` is an optional nonce when sending a reply to a previous message.
- `expiry` is an optional expiry time (as a time object), which denotes the expiry of the
   message. Expired messages will not be processed by the reaction macro `<-` below.
- `reply-expected?` is a boolean indicated whether a reply is expected to this message.
   It is a hint for message routers to send back a control reply in case of routing
   errors.
Returns the nonce of the message or `#f` if the message was not sent because the destination
actor was detected as dead.

### ->>
```scheme
(->> dest msg
     replyto: (replyto #f)
     timeout: (timeo (default-reply-timeout)))
```
Sends a message to dest and waits for the reply.
- `replyto` is an optional nonce indicating a reply to a previous interaction.
- `timeout` is the timeout for receiving the reply, which must be a relative time (a positive real) or an absolute time (a time object).

Returns the value received in the reply message.

Raises an actor error if the message could not be sent because the destination was detected
as dead.

Raises a timeout error if waiting for the reply times out.

### -->
```scheme
(--> result)
```

Sends result as a reply to the source of the message in the current
reaction context; it must be invoked within the lexical scope of a
`<-` reaction.

### -->?
```scheme
(-->? result)
```

Conditionally sends result as a reply to the source of the message in
the current reaction context, if a reply is expected; it must be
invoked within the lexical scope of a `<-` reaction.

### <-
```scheme
(<- (pattern body ...) ...
    [,(reaction-rule-macro ...) ...]
    [,@(multiple-reaction-rules-macro ...) ...]
    [timeout: timeo]
    [(else body ...)])
```

Receives an enveloped message from the thread's mailbox matching one
of the patterns and dispatching the body accordingly; patterns are
matched with `match`.

If there is a timeout specified, it will raise a timeout error if no
message matching any of the patterns is received before the timeout
elapses.

If there is an `else` clause it will be dispatched immediately if
there is no message matching any of the patterns in the mailbox.

Within a reaction rule body, the following syntactic variables are set:
- `@envelope` is set to the message envelope; this is an instance of the `evenelope` struct.
- `@message`  is set to the envelope payload; this can be anything.
- `@dest`     is set to the envelope destination; this is where the message was sent, a thread or a handle.
- `@source`   is set to the envelope source; this is where the message came from, a thread or a handle.
- `@nonce`    is set to the envelope nonce; a monotonically increasing nonnegative integer.
- `@replyto`  is set to the envelope reply nonce; it can be #f if this message is not a reply to a previous message, or the nonce of a previously sent message.
- `@expiry`   is set to the envelope expiry; this is a `time` object, representing absolute expiration time.
- `@reply-expected?` is set to the envelope reply-expected hint; this is #t if the source is expecting a reply to this message.

### <<
```scheme
(<< (pattern body ...) ...
    [timeout: timeo]
    [(else body ...)])
```

Like `<-` but it destructures raw messages that can be anything, not
necessarily wrapped in an envelope. You don't normally have to use
this unless you are expecting to receive messages sent with a raw
primitive like `thread-send` or `send-message` and not with the send
operator(s).

There are no syntactic variables bound in the reaction context.

### envelope
```scheme
(defstruct envelope (message dest source nonce replyto expiry reply-expected?)
 ...)
```

Envelope structure for messages; you normally shouldn't construct
those by hand and let the send operators construct it for you.

The structure is provided so that you program raw reactions with `<<`,
for instance when writing a proxy actor.

The meanings and types of the struct fields are as defined as follows:
- `message`  is the payload; this can be anything.
- `dest`     is the destination actor; this is where the message was sent, a thread or a handle.
- `source`   is the source of the message; this is where the message came from, a thread or a handle.
- `nonce`    is the source-specific message nonce; a monotonically increasing nonnegative integer.
- `replyto`  is the destination-specific reply nonce; it can be #f if this message is not a reply to a previous message, or the nonce of a previously sent message.
- `expiry`   is envelope expiry; this is a `time` object, representing absolute expiration time.
- `reply-expected?` is hint for proxies; this is #t if the source is expecting a reply to this message.


### send-message
```scheme
(send-message actor msg)
```

Sends a message to an actor, which must be a thread or a handle.
Returns `#f` if the message was not sent because the actor was detected as dead.

You don't normally have to invoke this, it is invoked internally by
the send operators.  It is provided however in case you want to send
pre-constructed envelopes, for instance when writing a proxy actor.

### current-thread-nonce!
```scheme
(current-thread-nonce!)
```

Returns the current thread's numeric nonce and post increments.

You don't normally have to use this procedure, the nonce is
incremented automatically by the send operators. It is provided
however in case you want to construct your own envelopes, for instance
when writing a proxy actor.

### actor-authorized?
```scheme
(actor-authorized? actor)
```

Returns true if the actor (a thread or a handle) are authorized for administrative actions.

All threads within the process are implicitly authorized.

Remote actors must be authorized with the actor server using
`admin-authorize` if the actor server requires authentication.  This
happens by default if an administrative public key exists in the
ensemble directory. If none exists, the actor server will consider all
actors in the ensemble as authorized.

### actor-error
```scheme
(defstruct (actor-error <error>) ())
```

Structure for actor errors.

### raise-actor-error
```scheme
(raise-actor-error where what . irritants)
```

Raises an actor error.

### default-reply-timeout
```scheme
(default-reply-timeout)
```

The default reply timeout in seconds; initial value is 5s.

### set-default-reply-timeout!
```scheme
(set-default-reply-timeout! timeo)
```
Sets the default reply timeout.


## Handles and References

### make-handle
```scheme
(handle proxy ref)
```

Creates a handle for sending messages to an actor through a proxy.
- `proxy` is the actor who will receive the messages, a thread.
- `ref` is a `reference` to the actor being proxied; in general it is
  something the proxy can interpret; see `reference` below.

### handle?
```scheme
(handle? obj)
```

Predicate for handles.


### handle-proxy
```scheme
(handle-proxy h)
```

Returns the proxy in the handle.

### handle-ref
```scheme
(handle-ref h)
```

Returns the actor reference in the handle.

### reference
```scheme
(defmessage reference (server id))
```

References for actors in the ensemble.
- `server` is the server identifier where the actor resides.
- `id` is the actor identifier, generally a symbol for references by name.


### reference->handle
```scheme
(reference->handle ref (srv (current-actor-server)))
```

Creates a handle from a reference, using by default the current actor
server as the proxy.


## Protocols

### defmessage
```scheme
(defmessage id (field-name ...) struct-options ...)
```

Macro to define message types that can be efficiently marshalled as
protocol messages.

The structure is final and transparent, and it is automatically
registered in the message type registry where the unmarshaller can
find it.

::: tip Note
Messages _must_ be acyclic; if you want to send cyclic data you
can use a normal struct, but be aware that such structs will be
serialized/deserialized with the raw gambit serializer and carry the
whole type descriptor (including methods) with them.
:::

### message?
```scheme
(message? obj)
```

Predicate for instances of messages defined with `defmessage`.

### defcall-actor
```scheme
(defcall-actor (proc arg ...)
  expr
  [error: error-msg error-irritant ...])
```

Macro for defining synchronous interaction entry points for actors.

The macro defines a procedure that invokes an actor with `expr` and
unwraps the result.  If it is `!ok` the embedded value is returned.  If
it is `!error` an actor error is raised, using the optional error
message and irritants specified in the definition.

### !ok
```scheme
(defmessage !ok (value))
```

Message indicating a successful invocation of an actor.

### !error
```scheme
(defmessage !error (message))
```

Message indicating an error in an actor invocation. The message is a
diagnostic string, that will be included in the error raised by
`defcall-actor` definitions.

### with-result
```scheme
(with-result expr [fail!])
```

Evaluates `expr` and matches the result; if it is `!ok` the embedded
value is returned.  If it is `!error` an error is raised by invoking
the `fail!` (`error` by default) procedure with the error message.


## Actor Management Protocol

### !ping
```scheme
(defmessage !ping ())
```

Message sent to check liveness of an actor; the actor must reply with
`(!ok 'OK)` if it is live.

### @ping
```scheme
(defrule (@ping)
  ((!ping) (--> (!ok 'OK))))
```

Reaction macro to automatically respond to `!ping` messages.

You can use this in reaction context (`<-`) with the gnostic `,(@ping)` syntax.


### !shutdown
```scheme
(defmessage !shutdown ())
```

Message sent to request an actor to gracefully shutdown.

### @shutdown
```scheme
(defrule (@shutdown exit ...)
  ((!shutdown)
   (-->? (!ok (void)))
   exit ...))
```

Reaction macro to automatically (conditionally) respond to a `!shutdown` message.

You can use this in reaction context (`<-`) with the gnostic
`,(@shutdown exit-actor-loop ...)` syntax.

### @unexpected
```scheme
(defrule (@unexpected logf)
  (unexpected
   (logf "unexpected message from ~a: ~a" @source @message)
   (-->? (!error "unexpected message"))))
```

Reaction macro to automatically log and conditionally respond to unexpected messages.

You can use this in reaction contex (`<-`) with the gnostic
`,(@unexpected warnf)` syntax.


### Tickers

#### ticker
```scheme
(ticker peer (period 1) (tick 'tick))
```

Runs in a loop sending `!tick` messages to `peer` every elapsed `period` (in seconds).

You can spawn tickers to send heartbeat messages to an actor like this:
```scheme
(spawn/name 'ticker ticker (current-thread))
```

#### ticker-after
```scheme
(ticker-after peer initial-delay (period 1) (tick 'tick))
```

Runs `ticker` after sleeping for `initial-delay` (in seconds).

#### after
```scheme
(after time peer (tick 'tick))
```

Sleeps for `time` and sends a tick to the specified peer.

#### !tick
```scheme
(defmessage !tick (id seqno))
```

This is the message sent by `ticker` and related procedures to signify a temporal tick.
- `id` is the identifier of the tick, which is a hint for actors to
  demultiplex multiple tick sources.
- `seqno` is the sequence number of the tick.


### Actor Monitors

#### actor-monitor
```scheme
(actor-monitor actor peer (send ->))
```

Waits for `actor` to terminate by joining it and sends an
`!actor-dead` message to `peer` when it exits. The `actor` must be a
thread.

The `send` procedure is used to send the message; if you are
processing raw messages with `<<` in your actor's reaction loop, you
can use `send-message` instead of `->` to avoid wrapping the
notification in an envelope.

You can spawn an actor monitor to notify you of thread exits like this:
```scheme
(spawn/name 'actor-monitor actor-monitor actor (current-thread))
```

#### !actor-dead
```scheme
(defmessage !actor-dead (thread))
```

Message sent by actor monitors to notify or a monitored thread exit.


## The Actor Server

### Server Addresses

Actor server addresses can be:
- UNIX domain addresses.
- TCP addresses.
- TLS addresses.

#### Unix Addresses
A UNIX domain address is denoted like this:
```
[unix: hostname path]
```

`hostname` is the name of the host where the server is
accessible and `path` is the socket path; they are both strings.

Actor servers will never try to connect to UNIX addresses in different
hosts.

#### TCP Addresses
A TCP address is denoted like this:
```
[tcp: inet-addr]
```

`inet-addr` is an Internet address; normally a pair of a host address
and a port or a string encoded Internet address of the form
`"host:port"`.
See the [:std/net/address](address.md#internet-addresses) module for more details.

::: warning
Do not use bare TCP addresses in production, as you will vulnerable to
Man in the Middle attacks.  Gerbil actors only support them for
development and debugging purposes; you _should_ use TLS in production.
:::

#### TLS Addresses
A TLS address is denoted like this:
```
[tls: inet-addr]
```

`inet-addr` is an Internet address; normally a pair of a host address
and a port or a string encoded Internet address of the form
`"host:port"`.
See the [:std/net/address](address.md#internet-addresses) module for more details.


### current-actor-server
```scheme
(current-actor-server)
```

Parameter denoting the current actor server.

This parameter is set automatically by `start-actor-server!` and
`call-with-ensemble-server`; you don't normally have to set it
manually.

### start-actor-server!
```scheme
(start-actor-server! identifier:  (id (make-random-identifier))
                     tls-context: (tls-context (get-actor-tls-context id))
                     cookie:      (cookie (get-actor-server-cookie))
                     admin:       (admin (get-admin-pubkey))
                     auth:        (auth #f)
                     addresses:   (addrs [])
                     ensemble:    (known-servers (default-known-servers)))

```

Starts an actor server, sets the `current-actor-server` parameter and
returns the main server thread.
- `identifier` is the server identifier; if you don't specify one, a random server
  identifier will be generated.
- `tls-context` is the server's TLS context, which can be omitted if this is a development
  server. By default it is looked up in `GERBIL_PATH/ensemble/server/<server-id>/tls`.
- `cookie` is the ensemble cookie; normally resides in `$GERBIL_PATH/ensemble/cookie`.
  Note that the administrator has to explicitly create a cookie for the ensemble, it is
  not automatically created.
- `admin` is the (optional) administrative public key; normally resindes in
  `$GERBIL_PATH/ensemble/admin.pub`.
- `auth`: a hash table mapping server ids to capabilities; these are preauthorized
  server capabilities.
- `addresses` is the list of addresses the server should listen; by default it is empty,
  making this a transient actor server.
- `ensemble` specifies statically known hosts; it is a hash table mapping server identifiers
  to lists of addresses.
  The default known servers only contain the registry with the default registry address.

### stop-actor-server!
```scheme
(stop-actor-server! (srv (current-actor-server)))
```

Stops and joins an actor server.

### actor-server-identifier
```scheme
(actor-server-identifier (srv (current-actor-server)))
```

Returns an actor server's identifier.

### register-actor!
```scheme
(register-actor! name (srv (current-actor-server)))
```

Registers the current thread in an actor server as an actor with the name `name`.

### connect-to-server!
```scheme
(connect-to-server! id (addrs #f) (srv (current-actor-server)))
```

Instructs an actor server to connect to another server.
- `id` is the identifier of the target server
- `addrs` is an optional list of addresses; if none is specified and
  the server is unknown, its addresses will be resolved through the
  ensemble registry.

### list-actors
```scheme
(list-actors (srv (current-actor-server)))
```

Lists the actors registered with an actor server.
Returns a list of references.

### list-connections
```scheme
(list-connections (srv (current-actor-server)))
```

Lists the current connections of an actor server.
Returns an associative list, with the server identifier at the car and the
list of addresses connected at the cdr.

### default-known-servers
```scheme
(default-known-servers)
```

Returns a hash table with the default known servers.
By default it only contains the registry reachable in its default address.

### set-default-known-servers!
```scheme
(set-default-known-servers! servers)
```

Sets the default known servers; `servers` must be a hash table mapping
server identifiers to lists of addresses.

### default-registry-addresses
```scheme
(default-registry-addresses)
```

Returns the default registry addresses, as a list of addresses.  By
default the registry is reachable at `/tmp/ensemble/registry` in the
current host.

### set-default-registry-addresses!
```scheme
(set-default-registry-addresses! addrs)
```

Sets the default registry addresses.

### server-address-cache-ttl
```scheme
(server-address-cache-ttl)
```

Returns the actor's server address cache TTL in seconds (a real number);
by default this is 5 minutes.

### set-server-address-cache-ttl!
```scheme
(set-server-address-cache-ttl! ttl)
```

Sets the actor server's address cache TTL (in seconds, a real number).




## Ensemble Servers
### Server Identifiers
A server identifier is a symbol, within some ensemble domain. A fully
qualified server identifier is a pair with a the relative server id in
the car and the ensemble domain in the cdr.

#### server-identifier
```
(server-identifier id)
```

Validates and returns the fully qualified server identifier for id.
The validation checks that it is either a symbol or a pair of symbols; if it is a plain symbol (naked server identifier) it returns a pair with the server id at the car and the domain at the cdr.

#### ensemble-domain
```
(def ensemble-domain
  (make-parameter '/))
```

Parameter containing the current ensemble domain, as a symbol.

### Ensemble Server Configuration
#### Schema
This is the schema for ensemble server configuration:
```
config: ensemble-server-v0

;;; ensemble
domain: <symbol>
identifier: <server-identifier>
supervisor: <server-identifier>
registry:   <server-identifier>
cookie:     <path>
admin:      <path>

;;; execution
role:    <symbol>
secondary-roles: (<symbol> ...)
exe:     <string>
args:    (<string> ...)
policy:  <symbol>
env:     <string>
envvars: (<string> ...)

;;; logging
log-level: <symbol>
log-file:  <path>
log-dir:   <path>

;;; bindings
addresses: (<address> ...)
auth: ((<server-identifier> <capability>) ...)
known-servers: ((<server-identifier> <address> ...) ...)

;;; application specific configuration
application: ((<symbol> config ...) ...)
```

#### ensemble-server-path
```scheme
(ensemble-server-path server-id (domain (ensemble-domain)) (base (gerbil-path)))
```

Returns the directory for server specific data.

#### ensemble-server-config-path
```
(ensemble-server-config-path server-id (domain (ensemble-domain)) (base (gerbil-path)))
```

Returns the path for a server configuration.

#### load-ensemble-server-config-file
```
(load-ensemble-server-config-file path)
```

Loads an ensemble server configuration from a file.

#### load-ensemble-server-config
```
(load-ensemble-server-config server-id
   (domain (ensemble-domain))
   (base (gerbil-path)))
```

Loads an ensemble server configuration from the file system by server identifier.


#### empty-ensemble-server-config
```
(empty-ensemble-server-config)
```

Returns a (fresh) empty ensemble server configurati
#### current-ensemble-server-config
```
(current-ensemble-server-config)
```
Parameter containing the current ensemble server configuration; this is automatically set by `become-ensemble-server!`.


### become-ensemble-server!
```
(become-ensemble-server! cfg thunk)
```

The current thread becomes an ensemble server; `cfg` is the ensemble server configuration,
which is used to make the appropriate `call-with-ensemble-server`.

### call-with-ensemble-server
```scheme
(call-with-ensemble-server server-id thunk
                           log-level:   (log-level 'INFO)
                           log-file:    (log-file #f)
                           listen:      (listen-addrs [])
                           announce:    (public-addrs #f)
                           registry:    (registry-addrs #f)
                           roles:       (roles [])
                           tls-context: (tls-context (get-actor-tls-context server-id))
                           cookie:      (cookie (get-actor-server-cookie))
                           admin:       (admin (get-admin-pubkey))
                           auth:        (auth #f))
```

This is the programmatic equivalent of `gxensemble run`; first it
starts the logger with the appropriate options, and then it starts a
new actor server with identifier `server-id`, starts the loader
service, adds the server to the ensemble, and then invokes thunk.
When the thunk exits, it shuts down the actor server and removes the
server-id from the ensemble.

Options:
- `log-level`: logging level to use; INFO by default
- `log-file`: log file for the logger; if it is "-" then the canonical
  server log is used; this file is at
  `$GERBIL_PATH/ensemble/server/<server-id>/log`.
- `listen`: a list of addresses for the actor server to listen to, in
  addition to the default unix address.
- `announce`: an optional list of addresses to announce to the registry,
  in addition to the default unix address. If it is not specified, then
  the listen addresses are announced.
- `registry`: an optional list of registry addresses. If it is not specified,
  then the default registry address is used.
- `roles`: a list of roles the server fullfills in the registry.
- `tls-context` is the server's TLS context, which can be omitted if this is a development
  server. By default it is looked up in `GERBIL_PATH/ensemble/server/<server-id>/tls`.
- `cookie`: the cookie to use; by default it uses the ensemble cooke in
  `$GERBIL_PATH/ensemble/cookie`.
- `admin`: the administrative public key, if any; by default it uses the public
   key in `$GERBIL_PATH/ensemble/admin.pub` if it exists.
- `auth`: a hash table mapping server ids to capabilities; these are preauthorized
  server capabilities.

## Primitive Ensemble Control

This is programmatic functionality for operations normally performed
using the `gxensemble` tool; see the [ensemble tutorial](/tutorials/ensemble.md)
for more information.

### stop-actor!
```scheme
(stop-actor! ref (srv (current-actor-server)))
```

Stops an actor referred by `ref` by sending it a `!shutdown` request.

### remote-stop-server!
```
(remote-stop-server! srv-id (srv (current-actor-server)))
```

Stops the remote server with identifier `srv-id`.

### remote-list-actors
```scheme
(remote-list-actors srv-id (srv (current-actor-server)))
```

Lists registered actors at the remote server with identifier `srv-id`.

### remote-connect-to-server!
```scheme
(remote-connect-to-server! from-id to-id (addrs #f) (srv (current-actor-server)))
```

Asks the remote server with identifier `from-id` to connect to the
server with identifier `to-id`.  If the optional addresses `addrs` are
not specified, then the `to-id` server will be looked up in the registry.

### remote-list-connections
```scheme
(remote-list-connections srv-id (srv (current-actor-server)))
```

Lists the connections of a remote server with identifier `srv-id`.

### remote-load-library-module
```scheme
(remote-load-library-module srv-id mod (srv (current-actor-server)))
```

Asks the remote server with identifier `srv-id` to load the library module `mod`.

### remote-load-code
```scheme
(remote-load-code srv-id object-file-path (srv (current-actor-server)))
```

Asks the remote server with identifier `srv-id` to load a code object file.

### remote-eval
```scheme
(remote-eval srv-id expr (srv (current-actor-server)))
```

Evaluates `expr` in the remote server with identifier `srv-id`.

### ping-server
```scheme
(ping-server srv-id (srv (current-actor-server)))
```

Pings the remote server with identifier `srv-id`.

### ping-actor
```scheme
(ping-actor ref (srv (current-actor-server)))
```

Pings the actor referred by `ref`.

### ensemble-add-server!
```scheme
(ensemble-add-server! id addrs roles (srv (current-actor-server)))
```

Adds a server to the ensemble registry:
- `id` is the server identifier
- `addrs` is the list of actor server addresses.
- `roles` is a list of roles for the server; a list of symbols.

### ensemble-remove-server!
```scheme
(ensemble-remove-server! id (srv (current-actor-server)))
```

Removes the server with identifier `id` from the ensemble registry.

### ensemble-list-servers
```scheme
(ensemble-list-servers (srv (current-actor-server)))
```

Lists the current ensemble servers.

### ensemble-lookup-server
```scheme
(ensemble-lookup-server id (srv (current-actor-server)))
```

Looks up a server's addresses in the registry.

### ensemble-lookup-servers/role
```scheme
(ensemble-lookup-servers/role role (srv (current-actor-server)))
```

Looks up servers (and their addresses) that fulfill `role` in the
ensemble.

### admin-authorize
```scheme
(admin-authorize privk srv-id authorized-server-id (srv (current-actor-server))
                 capabilities: (cap '(admin)))
```

Authorizes the capabilities specified by `cap` with administrative
privileges for `authorized-server-id` in the remote server `srv-id`,
using the private key `privk`. `cap` is a list of symbols denoting
the capabilities of the authorized server; the `admin` capability
implies all other capabilities.

### admin-retract
```scheme
(admin-retract srv-id authorized-server-id (srv (current-actor-server)))
```

Retracts the capabilities previously confered to
`authorized-server-id` within the context of `srv-id`.  Note that the
in-process actor server must have `admin` capabilities.

### get-admin-pubkey
```scheme
(get-admin-pubkey (path (default-admin-pubkey-path)))
```

Loads the administrative public key from the specified `path`, if it exists

### get-admin-privkey
```scheme
(get-admin-privkey passphrase (path (default-admin-privkey-path)))
```

Loads and decrypts the administrative private key from the specified `path`, if it exists

### default-admin-pubkey-path
```scheme
(default-admin-pubkey-path)
```

The default path for the ensemble admin public key; defaults to `$GERBIL_PATH/ensemble/admin.pub`.

### default-admin-privkey-path
```scheme
(default-admin-privkey-path)
```

The default path for the encrypted ensemble admin private key; defaults to `$GERBIL_PATH/ensemble/admin.priv`.


## Ensemble Supervisory Operations

This is the programmatic functionality for operations normally performed using the `gxensemble` tool; see the [advanced ensemble tutorial](/tutorials/advanced-ensemble.md)
for more information.

### Ensemble Configuration
#### Schema
This is the schema for supervised (structured) ensemble configuration:
```
;;; config: config versioned type, current is ensemble-v0
config: ensemble-v0
;;; supervisory domain for the ensemble
domain: <domain>
;;; [optional] root path for ensemble executions
root: <path>
;;; [optional] supervisor public address (over TLS)
public-address: <inet-address>

;;; supervisory services
services: (
 ;;; supervisor config
 supervisor: <ensemble-server-config>
 ;;; registry config for the local ensemble
 registry: <ensemble-server-config>
 ;;; [optional] resolver config for distributed ensemble name resolution
 resolver: <ensemble-server-config>
 ;;; [optional] broadcast config
 broadcast: <ensemble-server-config>
)

;;; roles -> execution mapping
roles:
 ((<role>  ; symbol
   ;;; for each role define an execution rule:
   ;;; the program is started as <exe> <prefix> ... <server-identifier> <suffix> ...
   ;;; the server configuration will be in the <ensemble-server-path>/config
   ;;; <program>: the symbol 'self for single binary deployments
   ;;; or an executable path (string)
   exe: <program>
   ;;; optional executable argument prefix
   prefix: (<string> ...)
   ;;; optional executable argument suffix
   suffix: (<string> ...)
   ;;; supervision policy
   policy: <supervisory-policy>
   ;;; optional role server configuration template
   server-config: <ensemble-server-config>
   )
 ...)

;;; [optional] preloaded server configuration; the supervisor on its own is capable
;;; of receiving remote updates, executables, and server execution instructions.
preload: (
 ;;; static preloaded server configuration
 servers:
 ((domain
   ;;; server identifier
   server: <server-identifier>
   ;;; primary role
   role: <role>
   ;;; [optional] server configuration, the role template is overlayed
   server-config: <ensemble-server-config>
  )
  ... )

;;; dynamic preloaded worker server configuration
 workers:
 ((domain
   ;;; server id prefix; the actual server id will be <prefix>-<seqno>
   prefix: <id>
   ;;; number of servers
   servers: <fixnum>
   ;;; primary role
   role: <role>
   ;;; [optional] server configuration, the role template is overlayed
   server-config: <ensemble-server-config>
  )
 ...)
)
```
#### ensemble-config-path
```
(ensemble-config-path (base (gerbil-path)))
```

Returns the ensemble configuration path.

#### ensemble-base-path
```
(ensemble-base-path (base (gerbil-path)))
```

Returns the base directory for the ensemble.

#### load-ensemble-config-file
```
(load-ensemble-config-file path)
```

Loads an ensemble configuration from a file.

#### load-ensemble-config
```
(load-ensemble-config (base (gerbil-path)))
```

Loads the ensemble configuration from the file system.

#### empty-ensemble-config
```
(empty-ensemble-config)
```

Returns a (fresh) empty ensemble configuration.

### become-ensemble-supervisor!
```
(become-ensemble-supervisor! cfg (thunk void))
```

The current thread of control becomes an ensemble supervisor with
config `cfg`, executing the thunk in the appropriate context.

### ensemble-lookup-supervisors
```
(ensemble-lookup-supervisors (srv (current-actor-server)))
```

Lookup all known supervisors by role.
Returns a list of supervisor server ids known to the (current) actor server.

### ensemble-list-domain-servers
```
(ensemble-list-domain-servers
 domain: (domain (ensemble-domain))
 role: (role #f)
 actor-server: (srv (current-actor-server)))
```

List all supervised servers in a domain (and its subdomains).
Returns an alist, associating a supervisor with a list of servers.

### ensemble-supervisor-list-servers
```
(ensemble-supervisor-list-servers
 supervisor: (super (ensemble-domain-supervisor))
 domain: (domain #f)
 role: (role #f)
 actor-server: (srv (current-actor-server)))
```

List all servers supervised by `super`, optionally under a specific
domain and filtered by a role.

### ensemble-supervisor-start-server!
```
(ensemble-supervisor-start-server!
 supervisor: (super (ensemble-domain-supervisor))
 role: role
 server-id: server-id
 domain: (domain (ensemble-domain))
 config: (config #f)
 actor-server: (srv (current-actor-server)))
```

Start a new supervised server for a (primary) role.
Returns the server identifier.

### ensemble-supervisor-start-workers!
```
(ensemble-supervisor-start-workers!
 supervisor: (super (ensemble-domain-supervisor))
 role: role
 server-id-prefix: prefix
 workers: count
 domain: (domain (ensemble-domain))
 config: (config #f)
 actor-server: (srv (current-actor-server)))
```

Start a number of supervised worker servers.
Returns a list of server identifiers.

### ensemble-supervisor-stop-servers!
```
(ensemble-supervisor-stop-servers!
 supervisor: (super (ensemble-domain-supervisor))
 servers: (server-ids #f)
 domain: (domain #f)
 role: (role #f)
 actor-server: (srv (current-actor-server)))
```

Stop some servers and remove them from the ensemble.
- `servers`: is an optional list of server ids
- `domain`: is an optional domain to stop
- `roles`: is a list of roles for the servers to stop

At least one of servers or roles should be specified to have any effect.
When specifying a domain, the roles select servers in the domain to stop.
If a domain but no roles or server-ids are specified, the entire domain
is shutdown.

### ensemble-supervisor-restart-servers!
```
(ensemble-supervisor-restart-servers!
 supervisor: (super (ensemble-domain-supervisor))
 servers: (server-ids #f)
 domain: (domain #f)
 role: (role #f)
 actor-server: (srv (current-actor-server)))
```

Restart some servers; semantics as in `ensemble-supervisor-stop-servers!` above.

### ensemble-supervisor-get-server-log
```
(ensemble-supervisor-get-server-log
 supervisor: (super (ensemble-domain-supervisor))
 server: server-id
 file: (logf "server.log")
 actor-server: (srv (current-actor-server)))
```

Get the log for some server.

### ensemble-shutdown!
```
(ensemble-shutdown! actor-server: (srv (current-actor-server)))
```

Shutdown the entire ensemble, including the supervisor(s).

### ensemble-supervisor-shutdown!
```
(ensemble-supervisor-shutdown!
 supervisor: (super (ensemble-domain-supervisor))
 actor-server: (srv (current-actor-server)))
```

Shutdown the (part of the) ensemble managed by a specific supervisor.

### ensemble-restart!
```
(ensemble-restart!
 restart-services: (restart-services? #f)
 actor-server: (srv (current-actor-server)))
```

Restart the entire ensemble.
If `restart-services?` is true, then the supervisory services are also restarted.

### ensemble-supervisor-restart!
```
(ensemble-supervisor-restart!
 supervisor: (super (ensemble-domain-supervisor))
 restart-services: (restart-services? #f)
 actor-server: (srv (current-actor-server)))
```

Restart a supervisor and the parts of the ensemble supervised by it.

### ensemble-supervisor-update-server-config!
```
(ensemble-supervisor-update-server-config!
 supervisor: (super (ensemble-domain-supervisor))
 server: server-id
 config: cfg
 mode: (mode 'upsert)
 restart: (restart? #t)
 actor-server: (srv (current-actor-server)))
```

Update a server configuration for a supervisor.

### ensemble-supervisor-get-server-config
```
(ensemble-supervisor-get-server-config
 supervisor: (super (ensemble-domain-supervisor))
 server: server-id
 actor-server: (srv (current-actor-server)))
```

Retrieve a server configuration from a supervisor.

### ensemble-update-config!
```
(ensemble-update-config!
 config: config
 mode: (mode 'upsert)
 actor-server: (srv (current-actor-server)))
```

Update the ensemble configuration for all known supervisors.

### ensemble-supervisor-update-config!
```
(ensemble-supervisor-update-config!
 supervisor: (super (ensemble-domain-supervisor))
 config: config
 mode: (mode 'upsert)
 actor-server: (srv (current-actor-server)))
```

Update the ensemble configuration for a specific supervisor.

### ensemble-get-config
```
(ensemble-get-config
 actor-server: (srv (current-actor-server)))
```

Collect the active ensemble configuration from all known supervisors.

### ensemble-supervisor-get-config
```
(ensemble-supervisor-get-config
 supervisor: (super (ensemble-domain-supervisor))
 actor-server: (srv (current-actor-server)))
```

Retrieve the active ensemble configuration from a specific supervisor.

### ensemble-upload-executable!
```
(ensemble-upload-executable!
 path: executable-gz-path
 deployment-path: deployment-path
 actor-server: (srv (current-actor-server)))
```

Upload an executable to all ensemble supervisors.

### ensemble-supervisor-upload-executable!
```
(ensemble-supervisor-upload-executable!
 supervisor: (super (ensemble-domain-supervisor))
 path: executable-gz-path
 deployment-path: deployment-path
 actor-server: (srv (current-actor-server)))
```
Upload an executable to a specific supervisor.

### ensemble-upload-environment!
```
(ensemble-upload-environment!
 path: env-targz-path
 deployment-path: deployment-path
 actor-server: (srv (current-actor-server)))
```
Upload a gerbil environment to all known supervisors.

### ensemble-supervisor-upload-environment!
```
(ensemble-supervisor-upload-environment!
 supervisor: (super (ensemble-domain-supervisor))
 path: env-targz-path
 deployment-path: deployment-path
 actor-server: (srv (current-actor-server)))
```

Upload a gerbil environment to a specific supervisor.

### ensemble-upload-filesystem-overlay!
```
(ensemble-upload-filesystem-overlay!
 fs: fs-targz-path
 path: deployment-path
 actor-server: (srv (current-actor-server)))
```

Upload a new server accessible filesystem overlay to all known supervisors.

### ensemble-supervisor-upload-filesystem-overlay!
```
(ensemble-supervisor-upload-filesystem-overlay!
 supervisor: (super (ensemble-domain-supervisor))
 path: fs-targz-path
 deployment-path: deployment-path
 actor-server: (srv (current-actor-server)))
```

Upload a new server accessible filesystem overlay to a specific supervisor.

### ensemble-supervisor-filesystem-upload!
```
(ensemble-supervisor-filesystem-upload!
 supervisor: (super (ensemble-domain-supervisor))
 type: type
 path: path
 deployment-path: deployment-path
 actor-server: (srv (current-actor-server)))
```

Generic upload functionality for a supervisor.

### ensemble-shell-command
```
(ensemble-shell-command
 command: cmd
 actor-server: (srv (current-actor-server)))
```

Execute a shell command on all known supervisors.

### ensemble-supervisor-shell-command
```
(ensemble-supervisor-shell-command
 supervisor: (super (ensemble-domain-supervisor))
 command: cmd
 actor-server: (srv (current-actor-server)))
```
Execute a shell command on a specific supervisor.

### ensemble-list-processes
```
(ensemble-list-processes actor-server: (srv (current-actor-server)))
```

List processes in all known supervisors.

### ensemble-supervisor-list-processes
```
(ensemble-supervisor-list-processes
 supervisor: (super (ensemble-domain-supervisor))
 actor-server: (srv (current-actor-server)))
```

List processes in a specific supervisor.

### ensemble-supervisor-kill-process!
```
(ensemble-supervisor-kill-process!
 supervisor: (super (ensemble-domain-supervisor))
 pid: pid
 signo: signo
 actor-server: (srv (current-actor-server)))
```

Kill a process in a specific supervisor.

### ensemble-exec-process!
```
(ensemble-exec-process!
 exe: exe
 args: args
 env: (env "default")
 envvars: (envvars #f)
 actor-server: (srv (current-actor-server)))
```

Execute a process in all known supervisors.

### ensemble-supervisor-exec-process!
```
(ensemble-supervisor-exec-process!
 supervisor: (super (ensemble-domain-supervisor))
 exe: exe
 args: args
 env: (env "default")
 envvars: (envvars #f)
 actor-server: (srv (current-actor-server)))
```

Execute a process in a specific supervisor.

### ensemble-supervisor-get-process-output
```
(ensemble-supervisor-get-process-output
 supervisor: (super (ensemble-domain-supervisor))
 pid: pid
 actor-server: (srv (current-actor-server)))
```

Get process output from a supervisor.

### ensemble-supervisor-restart-process!
```
(ensemble-supervisor-restart-process!
 supervisor: (super (ensemble-domain-supervisor))
 pid: pid
 actor-server: (srv (current-actor-server)))
```

Restart a process in a supervisor.

### ensemble-supervisor-invoke!
```
(ensemble-supervisor-invoke!
 supervisor: (super (ensemble-domain-supervisor))
 actor: actor
 message: msg
 actor-server: (srv (current-actor-server)))
```

Invoke an actor in the ensemble managed by a supervisor.

Note: this is a privileged operation, as the message is sent within
the context of the supervisor and thus has admin capabilities.


## Actor TLS related procedures

The following procedures offer programmatic functionality used by
actor servers and the `gxensemble` for managing TLS infrastructure.

### ensemble-tls-base-path
```scheme
(ensemble-tls-base-path)
```

Returns the base TLS directory for the ensemble; this is `$GERBIL_PATH/ensemble/tls`.


### ensemble-tls-server-path
```scheme
(ensemble-tls-server-path server-id)
```

Returns the directory for server specific data; this is `$GERBIL_PATH/ensemble/server/<server-id>`/tls.


### ensemble-tls-cafile
```scheme
(ensemble-tls-cafile)
```

Returns the base TLS CA file  for the ensemble; this is `$GERBIL_PATH/ensemble/tls/ca.pem`.

### get-actor-tls-context
```
(get-actor-tls-context server-id) -> tls-context or #f
```

Create an appropriate TLS context for the actor server with id `server-id`.
It loads the server's private key from `(ensemble-tls-server-path)`.

### actor-tls-certificate-id
```
(actor-tls-certificate-id x509)
```

Returns the actor server id for an x509 certificate.

### actor-tls-certificate-cap
```
(actor-tls-certificate-cap x509)
```

Returns the actor server capabilities embedded in an x509 certificate.

### actor-tls-host
```
(actor-tls-host server-id)
```

Returns the host name for an actor server as it is expected to appear in its certificate, for certificate verification purposes.

### generate-actor-tls-root-ca!
```
(generate-actor-tls-root-ca! root-ca-passphrase
                             domain: (domain "ensemble.local")
                             country-name: (country-name "UN")
                             organization-name: (organization-name "Mighty Gerbils")
                             common-name: (common-name (string-append organization-name " Root CA")))
```

Generates a new root CA.

### generate-actor-tls-sub-ca!
```
(generate-actor-tls-sub-ca! root-ca-passphrase
                            sub-ca-passphrase
                            country-name: (country-name "UN")
                            organization-name: (organization-name "Mighty Gerbils")
                            common-name: (common-name (string-append organization-name " Subordinate CA")))
```

Generates a new subordinate CA.

### generate-actor-tls-cafiles!
```
(generate-actor-tls-cafiles! force: (force? #f))
```

Generates the CA files for the actor CA.

### generate-actor-tls-cert!
```
(generate-actor-tls-cert! sub-ca-passphrase
                          server-id: server-id
                          capabilities: (capabilities [])
                          country-name: (country-name "UN")
                          organization-name: (organization-name "Mighty Gerbils")
                          location: (location "Internet"))
```

Issues a new actor TLS certificate.
